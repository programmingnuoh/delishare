function upload() {
    const submit = document.getElementById("form__btn");
    submit.addEventListener("click", (e) => {
        const reader = new FileReader();
        reader.readAsDataURL(e.target.files[0]);
        if (reader != null) {
            console.log ("OK")
        };
        document.getElementById("form").submit();
        // const XHR = new XMLHttpRequest();
        // XHR.open("PATCH", "/deli/${deliId}", true);
        // XHR.responseType = "json";
        // XHR.send(formData);
    });
  };
  window.addEventListener("load", upload)