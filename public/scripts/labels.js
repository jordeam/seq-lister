function checkAll(obj) {
    for (i = 0; i < obj.elements.length; i++)
        if (obj.elements[i].type == "checkbox" && /sc_[0-9]*/.test(obj.elements[i].name))
            obj.elements[i].checked = true;
}

function uncheckAll(obj) {
    for (i = 0; i < obj.elements.length; i++)
        if (obj.elements[i].type == "checkbox" && /sc_[0-9]*/.test(obj.elements[i].name))
            obj.elements[i].checked = false;
}

function saveParams(obj) {
  const locationId = obj.elements['locationId'].value;
  const requestOptions = {
    method: 'POST',
    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
    body: new URLSearchParams({
      nColumns: obj.elements.nColumns.value,
      nRows: obj.elements.nRows.value,
      initPos: obj.elements.initPos.value,
      paperId: obj.elements.paperId.value,
      // pageWidth: obj.elements.pageWidth.value,
      // pageHeight: obj.elements.pageHeight.value,
      topMargin: obj.elements.topMargin.value,
      bottomMargin: obj.elements.bottomMargin.value,
      leftMargin: obj.elements.leftMargin.value,
      rightMargin: obj.elements.rightMargin.value,
      horizSpacing: obj.elements.horizSpacing.value,
      drawBorderline: obj.elements.drawBorderline.value,
      includeRefs: obj.elements.includeRefs.value,
    }).toString(),
  };
  const request = new Request('/location/'+locationId+'/save_params', requestOptions);
  fetch(request)
    .then(res => res.text())
    .then(data => {
      const divbom = document.getElementById('save_msg');
      divbom.innerHTML = data;
    })
    .catch(error => console.error(error));
  editDimsHide();
}

function editDimsShow() {
  document.getElementById('dim_hide').style='display: none;';
  document.getElementById('dim_show').style='display: block;';
}

function editDimsHide() {
  document.getElementById('dim_hide').style='display: block;';
  document.getElementById('dim_show').style='display: none;';
}
