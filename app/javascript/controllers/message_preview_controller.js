import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="message-preview"
export default class extends Controller {
  connect() {}

  preview(){
    console.log("PREVIEW IS TRIGGERED ",this.targets.element.files)
    // this.clearPreviews();
    for(let i=0;i< this.targets.element.files.length;i++){
        let file = this.targets.element.files[i];
        const reader = new FileReader();
        console.log("INSIDE LOOP READER", file);
        console.log("INSIDE LOOP FILE", reader);
        this.createAndDisplayFilePreviewElements(file,reader);

    }
  }


  /**
   * 
   * @param {*} file 
   * @param {*} reader 
   */


  createAndDisplayFilePreviewElements(file, reader) {
    console.log("OUTSIDE CREATE AND DISPLAY")
    reader.onload = () => {
      console.log("INSIDE CREATE AND DISPLAY")
      let element = this.constructPreviews(file,reader);
      element.src = reader.result;
      element.setAttribute("href",reader.result);
      element.setAttribute("target","_blank");
      element.classList.add("attachment-preview");

      document.getElementById("attachment-previews").appendChild(element);
    }
    reader.readAsDataURL(file);
  }

  constructPreviews(file,reader){
    console.log("CHECKING CONSTRUCT PREVIEWS",file.type)
    let element;
    let cancelFunciton = (e) => this.removePreview(e);
    switch(file.type){
      case "image/jpeg":
      case "image/png":
      case "image/gif":
        element = this.createImageElement(cancelFunciton,reader);
        console.log("INSIDE SWITCH CASE",element)
        break;
        case "video/mp4":
        case "video/quicktime":
            element = this.createVideoElement(cancelFunciton);
            break;
        case "audio/mpeg":
        case "audio/mp3":
        case "audio/wave":
          element = this.createAudioElement(cancelFunciton);
          break;
        default:
          element = this.createDefaultElement(cancelFunciton);
      }
      element.dataset.filename = file.name;
      return element;
  }

  /**
   * 
   * 
   * 
   * @param {*} cancelFunciton
   * @param {*} reader
   * @return {HTMLElement}
   */

  createImageElement(cancelFunciton,reader)
  {
    console.log("INSIDE IMAGE ELEMNT")
    let cancelUploadButton,element;
    const image = document.createElement("img");
    image.setAttribute("style","background-image: url("+ reader.result+ ")");
    image.classList.add("preview-image"); 
    element = document.createElement("div");
    element.classList.add("attatchment-image-container", "file-removal");
    element.appendChild(image);
    cancelUploadButton = document.createElement("i");
    cancelUploadButton.classList.add(
      "bi",
      "bi-x-circle-fill",
      "cancel-upload-button"

    );
    cancelUploadButton.onclick = cancelFunciton;
    element.appendChild(cancelUploadButton) 
    return element
  }

  createAudioElement(cancelFunciton)
  {
    let cancelUploadButton,element;
    element = document.createElement("i");
    element.classList.add(     "bi",
    "bi-file-earmark-music-fill",
    "audio-preview-icon",
    "file-removal");
    cancelUploadButton = document.createElement("i");
    cancelUploadButton.classList.add(
      "bi",
      "bi-x-circle-fill",
      "cancel-upload-button"
    );

    cancelUploadButton.onclick = cancelFunciton;
    element.appendChild(cancelUploadButton) 
    return element
  }

  createVideoElement(cancelFunciton)
  {
    let cancelUploadButton,element;
    element = document.createElement("i");
    element.classList.add(
      "bi",
      "bi-file-earmark-play-fill",
      "video-preview-icon",
      "file-removal");
    cancelUploadButton = document.createElement("i");
    cancelUploadButton.classList.add(
      "bi",
      "bi-x-circle-fill",
      "cancel-upload-button"
    );

    cancelUploadButton.onclick = cancelFunciton;
    element.appendChild(cancelUploadButton) 
    return element
  } 


  createDefaultElement(cancelFunciton)
  {
    let cancelUploadButton,element;
    element = document.createElement("i");
    element.classList.add(
    "bi","bi-file-check-fill","file-preview-icon","file-removal"
  , "file-removal");
    cancelUploadButton = document.createElement("i");
    cancelUploadButton.classList.add(
      "bi","bi-x-circle-fill","cancel-upload-button"
    );

    cancelUploadButton.onclick = cancelFunciton;
    element.appendChild(cancelUploadButton) 
    return element
  }
  removePreview(event) {
    const target = event.target.parentNode.closest(".attachment-preview");
    const dataTransfer = new DataTransfer();
    let fileInput = document.getElementById("message_attachments");
    let files = fileInput.files;
    let filesArray = Array.from(files);

    filesArray = filesArray.filter((file) => {
      let filename = target.dataset.filename;
      return file.name !== filename;
    });
    target.parentNode.removeChild(target);
    filesArray.forEach((file) => dataTransfer.items.add(file));
    fileInput.files = dataTransfer.files;
  }

  clearPreviews() {
    document.getElementById("attachment-previews").innerHTML = "";
  }

}
  