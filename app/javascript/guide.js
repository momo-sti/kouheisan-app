document.addEventListener("turbo:load", function() {
  const tg = new tourguide.TourGuideClient({
    autoScroll: true
  });
  
  const startElement = document.querySelector("#start");
  if (startElement) {  // 要素が存在するかどうかチェック
    startElement.addEventListener("click", () => {
      tg.start();
    });
  }
});
