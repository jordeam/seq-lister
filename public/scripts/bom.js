function statusClicked(wdg) {
  const id = wdg.getAttribute("name");
  const div = document.getElementById(id);
  div.innerHTML = "";
}

function byPNClicked(wdg) {
  const id = wdg.getAttribute("name");
  const div = document.getElementById(id);
  const params = wdg.getAttribute("value");
  const lst = params.split(",");
  const locId = lst[0];
  const i = lst[1];
  //
  fetch(`/bom/${locId}/query?line=${i}`)
    .then(res => {return res.text();})
    .then(res => {
      div.innerHTML = res.toString();
    });
}

function leIdClicked(wdg) {
  const id = wdg.getAttribute("name");
  const params = wdg.getAttribute("value");
  const div = document.getElementById(id);
  const lst = params.split(",");
  const locId = lst[0];
  const i = lst[1];
  div.innerHTML = `<b> Location Entry location.id=${locId} line=${i}</b>`;
}

function insertWithPartnumber(index) {
  const form = document.getElementById('insert'+index);

  const loc_id = form.elements.loc_id.value;

  const requestOptions = {
    method: 'POST',
    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
    body: new URLSearchParams({
      qty: form.elements.qty.value,
      comp_id: form.elements.comp_id.value,
      pn: form.elements.pn.value,
      ordercode: form.elements.ordercode.value,
      labels: form.elements.labels.value,
      supplier_id: form.elements.supplier_id.value,
      rounding: form.elements.rounding.value,
    }).toString(),
  };

  const request = new Request('/bom/'+loc_id+'/insert', requestOptions);

  fetch(request)
    .then(response => response.html())
    .then(data => {
      const divbom = document.getElementById('bom'+index);
      divbom.innerHTML = '<p> Componente inserido</p>\n<hr>';
    })
    .catch(error => console.error(error));
}
