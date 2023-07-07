document.addEventListener("turbo:load", function() {
  setupSplitAmountUpdater();
});

window.setupSplitAmountUpdater = function() {
  const splitContainer = document.getElementById('split-container');
  // splitContainerが存在しない場合はここで処理を終了する
  if (!splitContainer) {
    return;
  }

  let totalAmount = parseFloat(splitContainer.getAttribute('data-total-amount'));

  const personCountInput = document.getElementById('person-count');
  const splitAmountDiv = document.getElementById('split-amount');

  let incrementButton = document.getElementById('increment-button');
  let decrementButton = document.getElementById('decrement-button');

  // 先に既存のイベントリスナーを全て削除
  incrementButton.replaceWith(incrementButton.cloneNode(true));
  decrementButton.replaceWith(decrementButton.cloneNode(true));

  // 再取得
  incrementButton = document.getElementById('increment-button');
  decrementButton = document.getElementById('decrement-button');

  incrementButton.addEventListener('click', () => {
    personCountInput.value = parseInt(personCountInput.value) + 1;
    updateSplitAmount();
  });

  decrementButton.addEventListener('click', () => {
    if (parseInt(personCountInput.value) > 1) {
      personCountInput.value = parseInt(personCountInput.value) - 1;
    }
    updateSplitAmount();
  });

  personCountInput.addEventListener('input', updateSplitAmount);

  function updateSplitAmount() {
    const personCount = parseInt(personCountInput.value);
    const splitAmount = totalAmount / personCount;
    // splitAmountの値を小数点第一位まで表示、整数であれば小数点以下を表示しない
    const displaySplitAmount = splitAmount % 1 === 0 ? splitAmount.toFixed(0) : splitAmount.toFixed(1);
    splitAmountDiv.textContent = `${displaySplitAmount}`;
  }

  // splitContainer の data-total-amount 属性の変更を監視する
  const observer = new MutationObserver(() => {
    console.log('data-total-amount attribute was modified.');
    totalAmount = parseFloat(splitContainer.getAttribute('data-total-amount'));
    updateSplitAmount();
  });

  // observer が split-container 要素の属性の変更を監視するように設定
  observer.observe(splitContainer, { attributes: true });

  updateSplitAmount();
  // turbo:loadイベントが発生したとき（ページが初めて読み込まれたとき、部分的に更新されたとき）にも関数を実行
  document.addEventListener('turbo:render', setupSplitAmountUpdater);
  
  document.addEventListener("turbo:load", function() {
    document.removeEventListener("turbo:load", setupSplitAmountUpdater);
  });
}
