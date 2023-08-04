import RustXcframework
public func desqueeze_image<GenericToRustStr: ToRustStr>(_ image_path: GenericToRustStr, _ output_path: GenericToRustStr, _ image_format: Optional<ImageFormat>, _ squeeze_factor: SqueezeFactor) async throws -> RustString {
    func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: __private__ResultPtrAndPtr) {
        let wrapper = Unmanaged<CbWrapper$desqueeze_image>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
        if rustFnRetVal.is_ok {
            wrapper.cb(.success(RustString(ptr: rustFnRetVal.ok_or_err!)))
        } else {
            wrapper.cb(.failure(ImageError(ptr: rustFnRetVal.ok_or_err!)))
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
            __swift_bridge__$desqueeze_image(wrapperPtr, onComplete, image_pathAsRustStr, output_pathAsRustStr, { if let val = image_format { val.isOwned = false; return val.ptr } else { return nil } }(), {squeeze_factor.isOwned = false; return squeeze_factor.ptr;}())
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

public class ImageFormat: ImageFormatRefMut {
    var isOwned: Bool = true

    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }

    deinit {
        if isOwned {
            __swift_bridge__$ImageFormat$_free(ptr)
        }
    }
}
public class ImageFormatRefMut: ImageFormatRef {
    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }
}
public class ImageFormatRef {
    var ptr: UnsafeMutableRawPointer

    public init(ptr: UnsafeMutableRawPointer) {
        self.ptr = ptr
    }
}
extension ImageFormat: Vectorizable {
    public static func vecOfSelfNew() -> UnsafeMutableRawPointer {
        __swift_bridge__$Vec_ImageFormat$new()
    }

    public static func vecOfSelfFree(vecPtr: UnsafeMutableRawPointer) {
        __swift_bridge__$Vec_ImageFormat$drop(vecPtr)
    }

    public static func vecOfSelfPush(vecPtr: UnsafeMutableRawPointer, value: ImageFormat) {
        __swift_bridge__$Vec_ImageFormat$push(vecPtr, {value.isOwned = false; return value.ptr;}())
    }

    public static func vecOfSelfPop(vecPtr: UnsafeMutableRawPointer) -> Optional<Self> {
        let pointer = __swift_bridge__$Vec_ImageFormat$pop(vecPtr)
        if pointer == nil {
            return nil
        } else {
            return (ImageFormat(ptr: pointer!) as! Self)
        }
    }

    public static func vecOfSelfGet(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<ImageFormatRef> {
        let pointer = __swift_bridge__$Vec_ImageFormat$get(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return ImageFormatRef(ptr: pointer!)
        }
    }

    public static func vecOfSelfGetMut(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<ImageFormatRefMut> {
        let pointer = __swift_bridge__$Vec_ImageFormat$get_mut(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return ImageFormatRefMut(ptr: pointer!)
        }
    }

    public static func vecOfSelfAsPtr(vecPtr: UnsafeMutableRawPointer) -> UnsafePointer<ImageFormatRef> {
        UnsafePointer<ImageFormatRef>(OpaquePointer(__swift_bridge__$Vec_ImageFormat$as_ptr(vecPtr)))
    }

    public static func vecOfSelfLen(vecPtr: UnsafeMutableRawPointer) -> UInt {
        __swift_bridge__$Vec_ImageFormat$len(vecPtr)
    }
}


public class ImageError: ImageErrorRefMut {
    var isOwned: Bool = true

    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }

    deinit {
        if isOwned {
            __swift_bridge__$ImageError$_free(ptr)
        }
    }
}
public class ImageErrorRefMut: ImageErrorRef {
    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }
}
public class ImageErrorRef {
    var ptr: UnsafeMutableRawPointer

    public init(ptr: UnsafeMutableRawPointer) {
        self.ptr = ptr
    }
}
extension ImageError: Vectorizable {
    public static func vecOfSelfNew() -> UnsafeMutableRawPointer {
        __swift_bridge__$Vec_ImageError$new()
    }

    public static func vecOfSelfFree(vecPtr: UnsafeMutableRawPointer) {
        __swift_bridge__$Vec_ImageError$drop(vecPtr)
    }

    public static func vecOfSelfPush(vecPtr: UnsafeMutableRawPointer, value: ImageError) {
        __swift_bridge__$Vec_ImageError$push(vecPtr, {value.isOwned = false; return value.ptr;}())
    }

    public static func vecOfSelfPop(vecPtr: UnsafeMutableRawPointer) -> Optional<Self> {
        let pointer = __swift_bridge__$Vec_ImageError$pop(vecPtr)
        if pointer == nil {
            return nil
        } else {
            return (ImageError(ptr: pointer!) as! Self)
        }
    }

    public static func vecOfSelfGet(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<ImageErrorRef> {
        let pointer = __swift_bridge__$Vec_ImageError$get(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return ImageErrorRef(ptr: pointer!)
        }
    }

    public static func vecOfSelfGetMut(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<ImageErrorRefMut> {
        let pointer = __swift_bridge__$Vec_ImageError$get_mut(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return ImageErrorRefMut(ptr: pointer!)
        }
    }

    public static func vecOfSelfAsPtr(vecPtr: UnsafeMutableRawPointer) -> UnsafePointer<ImageErrorRef> {
        UnsafePointer<ImageErrorRef>(OpaquePointer(__swift_bridge__$Vec_ImageError$as_ptr(vecPtr)))
    }

    public static func vecOfSelfLen(vecPtr: UnsafeMutableRawPointer) -> UInt {
        __swift_bridge__$Vec_ImageError$len(vecPtr)
    }
}


public class SqueezeFactor: SqueezeFactorRefMut {
    var isOwned: Bool = true

    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }

    deinit {
        if isOwned {
            __swift_bridge__$SqueezeFactor$_free(ptr)
        }
    }
}
public class SqueezeFactorRefMut: SqueezeFactorRef {
    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }
}
public class SqueezeFactorRef {
    var ptr: UnsafeMutableRawPointer

    public init(ptr: UnsafeMutableRawPointer) {
        self.ptr = ptr
    }
}
extension SqueezeFactor: Vectorizable {
    public static func vecOfSelfNew() -> UnsafeMutableRawPointer {
        __swift_bridge__$Vec_SqueezeFactor$new()
    }

    public static func vecOfSelfFree(vecPtr: UnsafeMutableRawPointer) {
        __swift_bridge__$Vec_SqueezeFactor$drop(vecPtr)
    }

    public static func vecOfSelfPush(vecPtr: UnsafeMutableRawPointer, value: SqueezeFactor) {
        __swift_bridge__$Vec_SqueezeFactor$push(vecPtr, {value.isOwned = false; return value.ptr;}())
    }

    public static func vecOfSelfPop(vecPtr: UnsafeMutableRawPointer) -> Optional<Self> {
        let pointer = __swift_bridge__$Vec_SqueezeFactor$pop(vecPtr)
        if pointer == nil {
            return nil
        } else {
            return (SqueezeFactor(ptr: pointer!) as! Self)
        }
    }

    public static func vecOfSelfGet(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<SqueezeFactorRef> {
        let pointer = __swift_bridge__$Vec_SqueezeFactor$get(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return SqueezeFactorRef(ptr: pointer!)
        }
    }

    public static func vecOfSelfGetMut(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<SqueezeFactorRefMut> {
        let pointer = __swift_bridge__$Vec_SqueezeFactor$get_mut(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return SqueezeFactorRefMut(ptr: pointer!)
        }
    }

    public static func vecOfSelfAsPtr(vecPtr: UnsafeMutableRawPointer) -> UnsafePointer<SqueezeFactorRef> {
        UnsafePointer<SqueezeFactorRef>(OpaquePointer(__swift_bridge__$Vec_SqueezeFactor$as_ptr(vecPtr)))
    }

    public static func vecOfSelfLen(vecPtr: UnsafeMutableRawPointer) -> UInt {
        __swift_bridge__$Vec_SqueezeFactor$len(vecPtr)
    }
}



