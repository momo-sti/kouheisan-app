window.addEventListener('turbo:load', (event) => {
  const bottomSheet = document.getElementById('bottomSheet');
  const arrowButton = document.getElementById('arrowButton');

  // bottomSheet と arrowButton が存在することを確認する
  if (bottomSheet && arrowButton) {
    // 初期状態はボトムシートを開いておく
    let isOpen = true;

    const openBottomSheet = () => {
        bottomSheet.style.transform = 'translateY(0)';
        arrowButton.style.transform = 'rotate(0deg)';
        bottomSheet.style.height = 'calc(25%)';
        isOpen = true;
    };

    const closeBottomSheet = () => {
        bottomSheet.style.transform = `translateY(calc(100% - 4.5rem))`;
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
