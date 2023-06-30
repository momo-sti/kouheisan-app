const bottomSheet = document.getElementById('bottom-sheet');

// 開く
function openBottomSheet() {
  bottomSheet.style.bottom = '0';
}

// 閉じる
function closeBottomSheet() {
  bottomSheet.style.bottom = '-15%'; // 15%だけ見えるようにする
}

// フリック操作に対応する
let start = null;
bottomSheet.addEventListener('touchstart', e => {
  start = e.touches[0].clientY;
}, false);

bottomSheet.addEventListener('touchend', e => {
  const end = e.changedTouches[0].clientY;
  // 上にフリックした場合
  if (start - end > 50) {
    openBottomSheet();
  }
  // 下にフリックした場合
  else if (end - start > 50) {
    closeBottomSheet();
  }
  start = null;
}, false);

document.addEventListener('DOMContentLoaded', (event) => {
  closeBottomSheet(); // ページが読み込まれたときにボトムシートを閉じる
});

document.addEventListener('DOMContentLoaded', (event) => {
  const bottomSheet = document.querySelector('#bottomSheet');
  const arrowButton = document.querySelector('#arrowButton');

  arrowButton.addEventListener('click', () => {
    bottomSheet.classList.toggle('open');
    arrowButton.classList.toggle('rotate');
  });
});