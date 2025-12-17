function statusClicked(wdg) {
  const id = wdg.getAttribute("name");
  const div = document.getElementById(id);
  div.innerHTML = "";
}

function byPNClicked(wdg) {
  const id = wdg.getAttribute("name");
  const div = document.getElementById("dialog-content");
  const params = wdg.getAttribute("value");
  const lst = params.split(",");
  const locId = lst[0];
  const i = lst[1];
  //
  fetch(`/bom/${locId}/query?line=${i}`)
    .then(res => {return res.text();})
    .then(res => {
      div.innerHTML = res.toString();
      document.getElementById('dialog').style="display: block";
      document.getElementById('back').style='pointer-events: none; opacity: 70%;';
    });
}

function createCompClicked(wdg) {
  const div = document.getElementById("dialog-content");
  const params = wdg.getAttribute("value");
  const lst = params.split(",");
  const locId = lst[0];
  const index = lst[1];
  //
  fetch(`/bom/${locId}/create?line=${index}`)
    .then(res => {return res.text();})
    .then(res => {
      div.innerHTML = res.toString();
      document.getElementById('dialog').style="display: block";
      document.getElementById('back').style='pointer-events: none; opacity: 70%;';
      const form = document.getElementById('insert-comp');
      if (form) {
        const obj = {value: form.elements.compname.value, dataset: {index: index}};
        on_name_changed(obj);
      }
    });
}

function useExistingPNClicked(wdg) {
  const div = document.getElementById("dialog-content");
  const params = wdg.getAttribute("value");
  const lst = params.split(",");
  const locId = lst[0];
  const index = lst[1];
  //
  fetch(`/bom/${locId}/insExistPN?line=${index}`)
    .then(res => {return res.text();})
    .then(res => {
      div.innerHTML = res.toString();
      document.getElementById('dialog').style="display: block";
      document.getElementById('back').style='pointer-events: none; opacity: 70%;';
      const form = document.getElementById('insert_exist_pn');
      if (form) {
        const obj = {value: form.elements.compname.value, dataset: {index: index}};
        on_name_changed_pn(obj);
      }
    });
}

function insertWithPartnumber(index) {
  const form = document.getElementById('insert-comp');

  const loc_id = form.elements.loc_id.value;

  const requestOptions = {
    method: 'POST',
    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
    body: new URLSearchParams({
      qty: form.elements.qty.value,
      comp_id: form.elements.comp_id.value,
      sc_id: form.elements.sc_id.value,
      pn: form.elements.pn.value.trim(),
      ordercode: form.elements.ordercode.value.trim(),
      rounding: form.elements.rounding.value,
      labels: form.elements.labels.value.trim(),
      supplier_id: form.elements.supplier_id.value,
      manufact_id: form.elements.manufact_id.value,
    }).toString(),
  };

  const request = new Request('/bom/'+loc_id+'/insert', requestOptions);

  fetch(request)
    .then(res => res.text())
    .then(data => {
      const divbom = document.getElementById('bom'+index);
      divbom.innerHTML = data;
      // hide dialog
      document.getElementById('dialog').style='display: none';
      document.getElementById('back').style = 'display: block';
    })
    .catch(error => console.error(error));
}

function on_supergroup_changed(obj) {
    const req = new Request('/group/select/'+obj.value);
    fetch(req)
    .then(res => {return res.text();})
    .then(data => {
        const elem = document.getElementById('group');
        console.log(`body=${data}`);
        console.log(`elem=${elem}`);
        elem.innerHTML = data;
    });
}

function on_name_changed(obj) {
  const name = obj.value;
  const index = +obj.dataset.index;
  if (name.length === 0) {
    const choices = document.getElementById("choices");
    choices.innerHTML = '';
    return;
  }
  const req = new Request('/search/onlycomp?expr=' + encodeURIComponent(name));
  fetch(req)
    .then(res => res.json())
    .then(data => {
      // console.log(data);
      choices.innerHTML = '';
      let table, tbody;
      if (data.length > 0) {
        // has some data
        const locid = +document.getElementById("locid").getAttribute('value');
        console.log(`locid = ${locid}`);
        const choices = document.getElementById("choices");
        let msgTag = document.createElement('h4');
        msgTag.innerHTML = "Ou escolha um Componente existente abaixo:";
        choices.appendChild(msgTag);
        table = document.createElement('table');
        tbody = document.createElement('tbody');
        const theaders = ['Grupo', 'Valor', 'Case'];
        const tr = document.createElement('tr');
        for (const e of theaders) {
          const th = document.createElement('th');
          th.innerHTML = `${e}`;
          tr.appendChild(th);
        }
        tbody.appendChild(tr);
        for (let elt of data) {
          const row_data = [elt.gname, elt.compname, elt.csname];
          const tr = document.createElement('tr');
          for (const e of row_data) {
            const td = document.createElement('td');
            td.textContent = e;
            tr.appendChild(td);
          }
          const td4 = document.createElement('td');
          td4.innerHTML = '<a class="btn btn-primary" href="/component/' + elt.comp_id +'"><img src="/image/component-icon.svg" alt="Editar" width="20pt" height="24pt"></a>';
          tr.appendChild(td4);
          const td5 = document.createElement('td');
          td5.innerHTML = '<button class="btn btn-primary" type="button" data-index="'+index+'" value="'+elt.comp_id+'" onclick="return insertWithComp(this);">Inserir</button>';
          tr.appendChild(td5);
          tbody.appendChild(tr);
        }
        table.appendChild(tbody);
        choices.appendChild(table);
      }

    });
  console.log(`name=${name}`);
}

function on_name_changed_pn(obj) {
  const name = obj.value;
  const index = +obj.dataset.index;
  const choices = document.getElementById("choices_pn");
  if (name.length === 0) {
    choices.innerHTML = 'Nenhum componente encontrado.';
    return;
  }
  const req = new Request('/search/comp_pn?expr=' + encodeURIComponent(name));
  fetch(req)
    .then(res => res.json())
    .then(data => {
      // console.log(data);
      choices.innerHTML = '';
      let table, tbody;
      if (data.length > 0) {
        // has some data
        const locid = +document.getElementById("locid").getAttribute('value');
        console.log(`locid = ${locid}`);
        let msgTag = document.createElement('h4');
        msgTag.innerHTML = "Ou escolha um Componente existente abaixo:";
        choices.appendChild(msgTag);
        table = document.createElement('table');
        tbody = document.createElement('tbody');
        const theaders = ['Grupo', 'Valor', 'Case', 'Partnumber', 'Manufact', 'Ordercode', 'Supplier'];
        const tr = document.createElement('tr');
        for (const e of theaders) {
          const th = document.createElement('th');
          th.innerHTML = `${e}`;
          tr.appendChild(th);
        }
        tbody.appendChild(tr);
        for (let elt of data) {
          const row_data = [elt.gname, elt.compname, elt.csname, elt.partnumber, elt.manufact, elt.ordercode, elt.supplier];
          const tr = document.createElement('tr');
          for (const e of row_data) {
            const td = document.createElement('td');
            td.textContent = e;
            tr.appendChild(td);
          }
          const td4 = document.createElement('td');
          td4.innerHTML = '<a class="btn btn-primary" href="/component/' + elt.comp_id +'"><img src="/image/component-icon.svg" alt="Editar" width="20pt" height="24pt"></a>';
          tr.appendChild(td4);
          const td5 = document.createElement('td');
          td5.innerHTML = '<button class="btn btn-primary" type="button" data-index="'+index+'" value="'+elt.id+'" onclick="return insertCompWithPN(this);">Inserir</button>';
          tr.appendChild(td5);
          tbody.appendChild(tr);
        }
        table.appendChild(tbody);
        choices.appendChild(table);
      }

    });
  console.log(`name=${name}`);
}

function insertWithComp(wdg) {
  const comp_id = +wdg.getAttribute("value");
  const index = +wdg.dataset.index;
  console.log(`index=${index} comp_id=${comp_id}`);
  const form = document.getElementById('insert-comp');
  const loc_id = form.elements.loc_id.value;
  const qty = +form.elements.qty.value;
  const round= +form.elements.round.value;
  const pn = form.elements.pn.value;
  const manufact_id = +form.elements.manufact_id.value;
  const ordercode = form.elements.ordercode.value;
  const supplier_id = +form.elements.supplier_id.value;
  const labels = form.elements.labels.value;
  const descr = form.elements.descr.value;
  const compname = form.elements.compname.value;
  const group_id = +form.elements.group_id.value;
  const case_id = +form.elements.case_id.value;
  const box = +form.elements.box.value;

  requestOptions = {
    method: 'POST',
    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
    body: new URLSearchParams({
      comp_id,
      index,
      loc_id,
      qty,
      round,
      pn,
      manufact_id,
      ordercode,
      supplier_id,
      labels,
      descr,
      compname,
      group_id,
      case_id,
      box,
    }).toString(),
  };
  const request = new Request('/bom/'+loc_id+'/insert_comp', requestOptions);
  fetch(request)
    .then(res => res.text())
    .then(data => {
      const divbom = document.getElementById('bom'+index);
      divbom.innerHTML = data;
      close_dialog();
    })
    .catch(error => console.error(error));

  return false;
}

function insertCompWithPN(wdg) {
  const index = +wdg.dataset.index;
  const sc_id = +wdg.getAttribute('value');
  console.log(`index=${index}`);
  const form = document.getElementById('insert_exist_pn');
  const loc_id = form.elements.loc_id.value;
  const qty = +form.elements.qty.value;
  const round= +form.elements.round.value;
  const labels = form.elements.labels.value;
  const box = +form.elements.box.value;

  requestOptions = {
    method: 'POST',
    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
    body: new URLSearchParams({
      index,
      loc_id,
      qty,
      round,
      labels,
      box,
    }).toString(),
  };
  const request = new Request('/bom/'+sc_id+'/insert_comp_w_pn', requestOptions);
  fetch(request)
    .then(res => res.text())
    .then(data => {
      const divbom = document.getElementById('bom'+index);
      divbom.innerHTML = data;
      close_dialog();
    })
    .catch(error => console.error(error));

  return false;
}

function close_dialog() {
  document.getElementById('dialog').style = 'display: none;';
  document.getElementById('back').style = 'display: block;';
}
