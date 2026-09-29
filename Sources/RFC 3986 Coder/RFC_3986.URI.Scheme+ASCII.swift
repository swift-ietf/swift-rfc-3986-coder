public import ASCII
public import Binary
public import Byte
public import RFC_3986

extension RFC_3986.URI.Scheme: @retroactive ASCII.Parseable {}

extension RFC_3986.URI.Scheme: @retroactive ASCII.Serializable, @retroactive Binary.Serializable {

    public static func serialize<Buffer: RangeReplaceableCollection>(
        _ value: Self,
        into buffer: inout Buffer
    ) where Buffer.Element == ASCII.Code {
        for byte in value.rawValue.utf8 { buffer.append(ASCII.Code(byte)) }
    }

    public static func serialize<Buffer: RangeReplaceableCollection>(
        _ value: Self,
        into buffer: inout Buffer
    ) where Buffer.Element == Byte {
        for byte in value.rawValue.utf8 { buffer.append(Byte(bitPattern: byte)) }
    }
}
