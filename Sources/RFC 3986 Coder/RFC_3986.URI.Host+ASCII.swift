public import ASCII
public import ASCII_Serializer
public import Binary_Serializable
public import Byte
public import IPv4_Standard
public import IPv6_Standard
public import Parseable_ASCII
public import RFC_3986

extension RFC_3986.URI.Host: @retroactive ASCII.Parseable {}

extension RFC_3986.URI.Host: @retroactive ASCII.Serializable, @retroactive Binary.Serializable {

    public static func serialize<Buffer: RangeReplaceableCollection>(
        _ host: Self,
        into buffer: inout Buffer
    ) where Buffer.Element == ASCII.Code {
        switch host {
        case .ipv4(let address):
            RFC_791.IPv4.Address.serialize(address, into: &buffer)

        case .ipv6(let scopedAddress):
            buffer.append(ASCII.Code.leftBracket)
            RFC_4291.IPv6.Address.serialize(scopedAddress.address, into: &buffer)
            if let zone = scopedAddress.zone {
                buffer.append(ASCII.Code.percentSign)
                buffer.append(ASCII.Code.`2`)
                buffer.append(ASCII.Code.`5`)
                for byte in zone.utf8 { buffer.append(ASCII.Code(byte)) }
            }
            buffer.append(ASCII.Code.rightBracket)

        case .registeredName(let name):
            for byte in name.utf8 { buffer.append(ASCII.Code(byte)) }
        }
    }

    public static func serialize<Buffer: RangeReplaceableCollection>(
        _ host: Self,
        into buffer: inout Buffer
    ) where Buffer.Element == Byte {
        var codes: [ASCII.Code] = []
        Self.serialize(host, into: &codes)
        buffer.append(contentsOf: codes.map(\.byte))
    }
}
