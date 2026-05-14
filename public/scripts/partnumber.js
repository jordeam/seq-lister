async function copyToClipboard(text_id) {
  // Get the text field element
  const copyText = document.getElementById(text_id);

  // Select the text field content (optional, improves mobile compatibility)
  copyText.select();
  copyText.setSelectionRange(0, 99999); // For mobile devices

  if (navigator.clipboard && window.isSecureContext) {
  // Copy the text inside the text field
  navigator.clipboard.writeText(copyText.value).then(() => {
      console.log(`Text copied=${copyText.value}`);
    });
  }
  else {
    // Fallback para o método antigo (execCommand)
    console.log(`copyText.value=${copyText.value}`);
    // Esconde o textarea para não afetar o layout

    copyText.focus();
    copyText.select();
    copyText.setSelectionRange(0, 99999); // Para dispositivos móveis

    if (!document.execCommand('copy'))
      alert('Não foi possível copiar: site não seguro.');
  }
}

// const botao = document.getElementById('btnCopiar');

// // Adiciona o evento de clique
// botao.addEventListener('click', async () => {
//   const textoParaCopiar = "Conteúdo para a área de transferência";

//   try {
//     await copyToClipboard(textoParaCopiar);
//     alert("Copiado com sucesso!");
//   } catch (err) {
//     console.error("Falha ao copiar", err);
//   }
