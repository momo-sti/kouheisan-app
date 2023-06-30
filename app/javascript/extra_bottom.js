document.addEventListener('DOMContentLoaded', (event) => {
  const bottomSheet = document.getElementById('bottomSheet');
  const arrowButton = document.getElementById('arrowButton');

  // bottomSheet と arrowButton が存在することを確認する
  if (bottomSheet && arrowButton) {
    // 初期状態はボトムシートが開いているとする
    let isOpen = true;

    const openBottomSheet = () => {
        bottomSheet.style.transform = 'translateY(0)';
        arrowButton.style.transform = 'rotate(0deg)';
        isOpen = true;
    };

    const closeBottomSheet = () => {
        bottomSheet.style.transform = `translateY(calc(100% - 2.5rem))`; // 2.5rem はボタンの高さに相当
        arrowButton.style.transform = 'rotate(180deg)';
        isOpen = false;
    };

    // ボタンが押されたときの動作
    arrowButton.addEventListener('click', () => {
        if (isOpen) {
            closeBottomSheet();
        } else {
            openBottomSheet();
        }
    });

    // 初期状態としてボトムシートを開いて表示
    openBottomSheet();
  }
});
