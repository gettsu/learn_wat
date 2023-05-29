(module 
    (import "wasi_unstable" "fd_write" (func $fd_write (param i32 i32 i32 i32) (result i32)))

    (memory 1)
    (export "memory" (memory 0))

    (func $f1 (result i32)
        i32.const 42)

    (func $main (export "_start")
        i32.const 0
        call $f1
        i32.store

        (i32.store (i32.const 4) (i32.const 0))
        (i32.store (i32.const 8) (i32.const 1))

        (call $fd_write
            (i32.const 1)
            (i32.const 4)
            (i32.const 1)
            (i32.const 20)
        )
        drop
    )
)
