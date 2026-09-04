public import ASCII
public import ASCII_Serializer
public import Binary_Serializable
public import Byte
public import Parseable_ASCII
public import RFC_3986

extension RFC_3986.URI.Authority: @retroactive ASCII.Parseable {}

extension RFC_3986.URI.Authority: @retroactive ASCII.Serializable, @retroactive Binary.Serializable
{

    public static func serialize<Buffer: RangeReplaceableCollection>(
        _ authority: Self,
        into buffer: inout Buffer
    ) where Buffer.Element == ASCII.Code {
        for byte in authority.rawValue.utf8 { buffer.append(ASCII.Code(byte)) }
    }

    public static func serialize<Buffer: RangeReplaceableCollection>(
        _ authority: Self,
        into buffer: inout Buffer
    ) where Buffer.Element == Byte {
        buffer.append(contentsOf: authority.rawValue.utf8.lazy.map(Byte.init(bitPattern:)))
    }
}
