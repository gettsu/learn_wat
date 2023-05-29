(module

    (import "wasi_unstable" "fd_write" (func $fd_write (param i32 i32 i32 i32) (result i32)))
    (memory 1)
    (export "memory" (memory 0))

    (table 2 funcref)
    (elem (i32.const 0) $f1 $f2)
    (func $f1 (result i32)
        i32.const 42)
    (func $f2 (result i32)
        i32.const 13)
    (type $return_i32 (func (result i32)))

    (func $callbyid (param $i i32) (result i32)
        local.get $i
        call_indirect (type $return_i32)
    )

    (func $main (export "_start")
        i32.const 60
        i32.const 0
        call $callbyid
        i32.store

        (i32.store (i32.const 8) (i32.const 60))
        (i32.store (i32.const 12) (i32.const 1))

        (call $fd_write
            (i32.const 1)
            (i32.const 8)
            (i32.const 1)
            (i32.const 20)
        )
        drop
    )
)
