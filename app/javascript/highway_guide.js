const tg = new tourguide.TourGuideClient();
document.querySelector('#start').addEventListener('click', () => {
  tg.start()  
})