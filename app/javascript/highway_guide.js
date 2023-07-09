const tg = new tourguide.TourGuideClient({
  autoScroll: true
});
document.querySelector('#start').addEventListener('click', () => {
  tg.start()  
});