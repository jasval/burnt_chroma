import RustXcframework
public func desqueeze_image<GenericToRustStr: ToRustStr>(_ image_path: GenericToRustStr, _ output_path: GenericToRustStr, _ image_format: Optional<ImageFormat>, _ squeeze_factor: ImageSqueezeFactor) async throws -> RustString {
    func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: __private__ResultPtrAndPtr) {
        let wrapper = Unmanaged<CbWrapper$desqueeze_image>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
        if rustFnRetVal.is_ok {
            wrapper.cb(.success(RustString(ptr: rustFnRetVal.ok_or_err!)))
        } else {
            wrapper.cb(.failure(RustString(ptr: rustFnRetVal.ok_or_err!)))
        }
    }

    return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<RustString, Error>) in
        let callback = { rustFnRetVal in
            continuation.resume(with: rustFnRetVal)
        }

        let wrapper = CbWrapper$desqueeze_image(cb: callback)
        let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

        return output_path.toRustStr({ output_pathAsRustStr in
            return image_path.toRustStr({ image_pathAsRustStr in
            __swift_bridge__$desqueeze_image(wrapperPtr, onComplete, image_pathAsRustStr, output_pathAsRustStr, __swift_bridge__$Option$ImageFormat.fromSwiftRepr(image_format), squeeze_factor.intoFfiRepr())
        })
        })
    })
}
class CbWrapper$desqueeze_image {
    var cb: (Result<RustString, Error>) -> ()

    public init(cb: @escaping (Result<RustString, Error>) -> ()) {
        self.cb = cb
    }
}
public enum ImageSqueezeFactor {
    case X1_33
    case X1_5
    case X1_75
    case X2
}
extension ImageSqueezeFactor {
    func intoFfiRepr() -> __swift_bridge__$ImageSqueezeFactor {
        switch self {
            case ImageSqueezeFactor.X1_33:
                return __swift_bridge__$ImageSqueezeFactor(tag: __swift_bridge__$ImageSqueezeFactor$X1_33)
            case ImageSqueezeFactor.X1_5:
                return __swift_bridge__$ImageSqueezeFactor(tag: __swift_bridge__$ImageSqueezeFactor$X1_5)
            case ImageSqueezeFactor.X1_75:
                return __swift_bridge__$ImageSqueezeFactor(tag: __swift_bridge__$ImageSqueezeFactor$X1_75)
            case ImageSqueezeFactor.X2:
                return __swift_bridge__$ImageSqueezeFactor(tag: __swift_bridge__$ImageSqueezeFactor$X2)
        }
    }
}
extension __swift_bridge__$ImageSqueezeFactor {
    func intoSwiftRepr() -> ImageSqueezeFactor {
        switch self.tag {
            case __swift_bridge__$ImageSqueezeFactor$X1_33:
                return ImageSqueezeFactor.X1_33
            case __swift_bridge__$ImageSqueezeFactor$X1_5:
                return ImageSqueezeFactor.X1_5
            case __swift_bridge__$ImageSqueezeFactor$X1_75:
                return ImageSqueezeFactor.X1_75
            case __swift_bridge__$ImageSqueezeFactor$X2:
                return ImageSqueezeFactor.X2
            default:
                fatalError("Unreachable")
        }
    }
}
extension __swift_bridge__$Option$ImageSqueezeFactor {
    @inline(__always)
    func intoSwiftRepr() -> Optional<ImageSqueezeFactor> {
        if self.is_some {
            return self.val.intoSwiftRepr()
        } else {
            return nil
        }
    }
    @inline(__always)
    static func fromSwiftRepr(_ val: Optional<ImageSqueezeFactor>) -> __swift_bridge__$Option$ImageSqueezeFactor {
        if let v = val {
            return __swift_bridge__$Option$ImageSqueezeFactor(is_some: true, val: v.intoFfiRepr())
        } else {
            return __swift_bridge__$Option$ImageSqueezeFactor(is_some: false, val: __swift_bridge__$ImageSqueezeFactor())
        }
    }
}
extension ImageSqueezeFactor: Vectorizable {
    public static func vecOfSelfNew() -> UnsafeMutableRawPointer {
        __swift_bridge__$Vec_ImageSqueezeFactor$new()
    }

    public static func vecOfSelfFree(vecPtr: UnsafeMutableRawPointer) {
        __swift_bridge__$Vec_ImageSqueezeFactor$drop(vecPtr)
    }

    public static func vecOfSelfPush(vecPtr: UnsafeMutableRawPointer, value: Self) {
        __swift_bridge__$Vec_ImageSqueezeFactor$push(vecPtr, value.intoFfiRepr())
    }

    public static func vecOfSelfPop(vecPtr: UnsafeMutableRawPointer) -> Optional<Self> {
        let maybeEnum = __swift_bridge__$Vec_ImageSqueezeFactor$pop(vecPtr)
        return maybeEnum.intoSwiftRepr()
    }

    public static func vecOfSelfGet(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<Self> {
        let maybeEnum = __swift_bridge__$Vec_ImageSqueezeFactor$get(vecPtr, index)
        return maybeEnum.intoSwiftRepr()
    }

    public static func vecOfSelfGetMut(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<Self> {
        let maybeEnum = __swift_bridge__$Vec_ImageSqueezeFactor$get_mut(vecPtr, index)
        return maybeEnum.intoSwiftRepr()
    }

    public static func vecOfSelfAsPtr(vecPtr: UnsafeMutableRawPointer) -> UnsafePointer<Self> {
        UnsafePointer<Self>(OpaquePointer(__swift_bridge__$Vec_ImageSqueezeFactor$as_ptr(vecPtr)))
    }

    public static func vecOfSelfLen(vecPtr: UnsafeMutableRawPointer) -> UInt {
        __swift_bridge__$Vec_ImageSqueezeFactor$len(vecPtr)
    }
}
public enum ImageFormat {
    case Png
    case Jpeg
    case Gif
    case WebP
    case Pnm
    case Tiff
    case Tga
    case Dds
    case Bmp
    case Ico
    case Hdr
    case OpenExr
    case Farbfeld
    case Avif
    case Qoi
    case Heic
    case NotSupported
}
extension ImageFormat {
    func intoFfiRepr() -> __swift_bridge__$ImageFormat {
        switch self {
            case ImageFormat.Png:
                return __swift_bridge__$ImageFormat(tag: __swift_bridge__$ImageFormat$Png)
            case ImageFormat.Jpeg:
                return __swift_bridge__$ImageFormat(tag: __swift_bridge__$ImageFormat$Jpeg)
            case ImageFormat.Gif:
                return __swift_bridge__$ImageFormat(tag: __swift_bridge__$ImageFormat$Gif)
            case ImageFormat.WebP:
                return __swift_bridge__$ImageFormat(tag: __swift_bridge__$ImageFormat$WebP)
            case ImageFormat.Pnm:
                return __swift_bridge__$ImageFormat(tag: __swift_bridge__$ImageFormat$Pnm)
            case ImageFormat.Tiff:
                return __swift_bridge__$ImageFormat(tag: __swift_bridge__$ImageFormat$Tiff)
            case ImageFormat.Tga:
                return __swift_bridge__$ImageFormat(tag: __swift_bridge__$ImageFormat$Tga)
            case ImageFormat.Dds:
                return __swift_bridge__$ImageFormat(tag: __swift_bridge__$ImageFormat$Dds)
            case ImageFormat.Bmp:
                return __swift_bridge__$ImageFormat(tag: __swift_bridge__$ImageFormat$Bmp)
            case ImageFormat.Ico:
                return __swift_bridge__$ImageFormat(tag: __swift_bridge__$ImageFormat$Ico)
            case ImageFormat.Hdr:
                return __swift_bridge__$ImageFormat(tag: __swift_bridge__$ImageFormat$Hdr)
            case ImageFormat.OpenExr:
                return __swift_bridge__$ImageFormat(tag: __swift_bridge__$ImageFormat$OpenExr)
            case ImageFormat.Farbfeld:
                return __swift_bridge__$ImageFormat(tag: __swift_bridge__$ImageFormat$Farbfeld)
            case ImageFormat.Avif:
                return __swift_bridge__$ImageFormat(tag: __swift_bridge__$ImageFormat$Avif)
            case ImageFormat.Qoi:
                return __swift_bridge__$ImageFormat(tag: __swift_bridge__$ImageFormat$Qoi)
            case ImageFormat.Heic:
                return __swift_bridge__$ImageFormat(tag: __swift_bridge__$ImageFormat$Heic)
            case ImageFormat.NotSupported:
                return __swift_bridge__$ImageFormat(tag: __swift_bridge__$ImageFormat$NotSupported)
        }
    }
}
extension __swift_bridge__$ImageFormat {
    func intoSwiftRepr() -> ImageFormat {
        switch self.tag {
            case __swift_bridge__$ImageFormat$Png:
                return ImageFormat.Png
            case __swift_bridge__$ImageFormat$Jpeg:
                return ImageFormat.Jpeg
            case __swift_bridge__$ImageFormat$Gif:
                return ImageFormat.Gif
            case __swift_bridge__$ImageFormat$WebP:
                return ImageFormat.WebP
            case __swift_bridge__$ImageFormat$Pnm:
                return ImageFormat.Pnm
            case __swift_bridge__$ImageFormat$Tiff:
                return ImageFormat.Tiff
            case __swift_bridge__$ImageFormat$Tga:
                return ImageFormat.Tga
            case __swift_bridge__$ImageFormat$Dds:
                return ImageFormat.Dds
            case __swift_bridge__$ImageFormat$Bmp:
                return ImageFormat.Bmp
            case __swift_bridge__$ImageFormat$Ico:
                return ImageFormat.Ico
            case __swift_bridge__$ImageFormat$Hdr:
                return ImageFormat.Hdr
            case __swift_bridge__$ImageFormat$OpenExr:
                return ImageFormat.OpenExr
            case __swift_bridge__$ImageFormat$Farbfeld:
                return ImageFormat.Farbfeld
            case __swift_bridge__$ImageFormat$Avif:
                return ImageFormat.Avif
            case __swift_bridge__$ImageFormat$Qoi:
                return ImageFormat.Qoi
            case __swift_bridge__$ImageFormat$Heic:
                return ImageFormat.Heic
            case __swift_bridge__$ImageFormat$NotSupported:
                return ImageFormat.NotSupported
            default:
                fatalError("Unreachable")
        }
    }
}
extension __swift_bridge__$Option$ImageFormat {
    @inline(__always)
    func intoSwiftRepr() -> Optional<ImageFormat> {
        if self.is_some {
            return self.val.intoSwiftRepr()
        } else {
            return nil
        }
    }
    @inline(__always)
    static func fromSwiftRepr(_ val: Optional<ImageFormat>) -> __swift_bridge__$Option$ImageFormat {
        if let v = val {
            return __swift_bridge__$Option$ImageFormat(is_some: true, val: v.intoFfiRepr())
        } else {
            return __swift_bridge__$Option$ImageFormat(is_some: false, val: __swift_bridge__$ImageFormat())
        }
    }
}
extension ImageFormat: Vectorizable {
    public static func vecOfSelfNew() -> UnsafeMutableRawPointer {
        __swift_bridge__$Vec_ImageFormat$new()
    }

    public static func vecOfSelfFree(vecPtr: UnsafeMutableRawPointer) {
        __swift_bridge__$Vec_ImageFormat$drop(vecPtr)
    }

    public static func vecOfSelfPush(vecPtr: UnsafeMutableRawPointer, value: Self) {
        __swift_bridge__$Vec_ImageFormat$push(vecPtr, value.intoFfiRepr())
    }

    public static func vecOfSelfPop(vecPtr: UnsafeMutableRawPointer) -> Optional<Self> {
        let maybeEnum = __swift_bridge__$Vec_ImageFormat$pop(vecPtr)
        return maybeEnum.intoSwiftRepr()
    }

    public static func vecOfSelfGet(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<Self> {
        let maybeEnum = __swift_bridge__$Vec_ImageFormat$get(vecPtr, index)
        return maybeEnum.intoSwiftRepr()
    }

    public static func vecOfSelfGetMut(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<Self> {
        let maybeEnum = __swift_bridge__$Vec_ImageFormat$get_mut(vecPtr, index)
        return maybeEnum.intoSwiftRepr()
    }

    public static func vecOfSelfAsPtr(vecPtr: UnsafeMutableRawPointer) -> UnsafePointer<Self> {
        UnsafePointer<Self>(OpaquePointer(__swift_bridge__$Vec_ImageFormat$as_ptr(vecPtr)))
    }

    public static func vecOfSelfLen(vecPtr: UnsafeMutableRawPointer) -> UInt {
        __swift_bridge__$Vec_ImageFormat$len(vecPtr)
    }
}


