use wasmtime::*;

fn main() -> wasmtime::Result<()> {
    let engine = Engine::default();
    let module = Module::from_file(&engine, "wat/hello.wat")?;
    let mut linker = Linker::new(&engine);

    linker.func_wrap(
        "host",
        "host_func",
        |caller: Caller<'_, u32>, param: i32| {
            println!("Got {} from WebAssembly", param);
            println!("my host state is: {}", caller.data());
        },
    )?;

    let mut store = Store::new(&engine, 0);
    let instance = linker.instantiate(&mut store, &module)?;
    let hello = instance.get_typed_func::<(), ()>(&mut store, "hello")?;
    hello.call(&mut store, ())?;

    Ok(())
}
