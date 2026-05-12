function copyToClipboard(text_id) {
  // Get the text field element
  const copyText = document.getElementById(text_id);

  // Select the text field content (optional, improves mobile compatibility)
  copyText.select();
  copyText.setSelectionRange(0, 99999); // For mobile devices

  // Copy the text inside the text field
  navigator.clipboard.writeText(copyText.value).then(() => {
      console.log(`Text copied=${copyText.value}`);
    });
}

