(module
    (import "wasi_unstable" "fd_write" (func $fd_write (param i32 i32 i32 i32) (result i32)))

    (memory 1)
    (export "memory" (memory 0))

    (data (i32.const 8) "hello world\n")
    (data (i32.const 32) "hogehoge\n")

    (func $main (export "_start")
        (i32.store (i32.const 0) (i32.const 8))
        (i32.store (i32.const 4) (i32.const 12))

        (i32.store (i32.const 24) (i32.const 32))
        (i32.store (i32.const 28) (i32.const 9))

        (if (i32.const 0)
            (then
                (call $fd_write
                    (i32.const 1)
                    (i32.const 0)
                    (i32.const 1)
                    (i32.const 20)
                )
                drop
            )
            (else
                (call $fd_write
                    (i32.const 1)
                    (i32.const 24)
                    (i32.const 1)
                    (i32.const 20)
                )
                drop
            )
        )
    )
)
