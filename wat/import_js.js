const importObject = {
  console: {
    log(arg) {
      console.log(arg);
    },
  },
};

WebAssembly.instantiateStreaming(fetch("import_js.wasm"), importObject).then(
  (obj) => {
    obj.instance.exports.logIt();
  }
);
