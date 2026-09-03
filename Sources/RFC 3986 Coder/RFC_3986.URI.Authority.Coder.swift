public import Byte
public import Coder
public import Cursor
public import Cursor_Standard_Library_Integration
public import RFC_3986
import Byte_Standard_Library_Integration
import Cursor_Coder
import Cursor_Parser_Optionally
import Either
import Iterator_Coder
import Parser
import Parser_Error
import Serializer

extension RFC_3986.URI.Authority {

    public struct Coder<Input: Cursor.`Protocol`<Byte, Never>, Buffer: RangeReplaceableCollection<Byte>>: Coding {

        public typealias Failure = RFC_3986.URI.Host.Error

        public init() {}

        @Coder::Coder.Builder<Input, Buffer>
        public var body: some Coding<Input, RFC_3986.URI.Authority, Buffer, Failure> {
            Coder::Coder.Sequence(Input.self, Buffer.self) {
                Parser.Optionally(
                    Coder::Coder.Sequence(Input.self, Buffer.self) {
                        RFC_3986.URI.Userinfo.Coder()
                        "@"
                    }
                )
                RFC_3986.URI.Host.Coder()
                Parser.Optionally(
                    Coder::Coder.Sequence(Input.self, Buffer.self) {
                        ":"
                        RFC_3986.URI.Port.Coder()
                    }
                )
            }
            .map(
                to: { output in RFC_3986.URI.Authority(userinfo: output.0, host: output.1, port: output.2) },
                from: { ($0.userinfo, $0.host, $0.port) }
            )
            .error.map { (failure) -> Failure in failure.value.value }
        }
    }

    public static var coder: Coder<ArraySlice<Byte>, [Byte]> { .init() }
}

extension RFC_3986.URI.Authority: Coder.Codable {}
