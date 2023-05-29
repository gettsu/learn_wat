(module
    (import "conosole" "log" (func $log (param i32)))
    (func (export "logIt")
        i32.const 13
        call $log))
