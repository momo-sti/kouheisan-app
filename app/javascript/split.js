document.addEventListener("turbo:load", function() {
  setupSplitAmountUpdater();
});

function setupSplitAmountUpdater() {
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
    const splitAmount = (totalAmount / personCount).toFixed(1);
    splitAmountDiv.textContent = `割り勘額: ¥${splitAmount}`;
  }

  updateSplitAmount();
}