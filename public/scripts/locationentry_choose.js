let createHidden = true;

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

function on_group_changed(obj) {
    const req = new Request('/component/select/'+obj.value);
    fetch(req)
    .then(res => {return res.text();})
    .then(data => {
        const elem = document.getElementById('comp');
        console.log(`body=${data}`);
        console.log(`elem=${elem}`);
        elem.innerHTML = data;
    });
}

function on_name_changed(obj) {
  const name = obj.value;
  if (name.length === 0) {
    const choices = document.getElementById("choices");
    choices.innerHTML = '';
    return;
  }
  let req;
  if (createHidden)
    req = new Request('/search/comp?expr=' + encodeURIComponent(name));
  else {
    return;
//    req = new Request('/search/onlycomp?expr=' + encodeURIComponent(name));
  }
  fetch(req)
    .then(res => res.json())
    .then(data => {
      // console.log(data);
      choices.innerHTML = '';
      let table, tbody;
      if (data.length > 0) {
        // has some data
        const locid = +document.getElementById("locid").getAttribute('value');
        const choices = document.getElementById("choices");
        table = document.createElement('table');
        tbody = document.createElement('tbody');
        const theaders = ['Grupo', 'Valor', 'Case'];
        if (createHidden)
          theaders.push('Partnumber', 'Fab.', 'Ordercode', 'Fornec.');
        const tr = document.createElement('tr');
        for (const e of theaders) {
          const td = document.createElement('td');
          td.innerHTML = `<strong>${e}</strong>`;
          tr.appendChild(td);
        }
        tbody.appendChild(tr);
        for (let elt of data) {
          const row_data = [elt.gname, elt.compname, elt.case];
          if (createHidden)
            row_data.push(elt.partnumber, elt.manufact, elt.ordercode, elt.supplier);
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
          const form = document.createElement('form');
          form.setAttribute('method', 'POST');
          form.setAttribute('action', '/locationentry/insert/'+locid);
          form.setAttribute('id', 'form'+elt.id);
          form.innerHTML = '<input type="hidden" name="supcode_id" value=' + elt.id + '> <input type="hidden" name="box"> <input type="hidden" name="quant" value=""> <input type="hidden" name="quantunit"> <input type="hidden" name="labels"> <button class="btn btn-primary" type="submit" name="form'+elt.id+'"onclick="return setFormData(this);">Inserir</button>';

          td5.appendChild(form);
          tr.appendChild(td5);
          tbody.appendChild(tr);
        }
        table.appendChild(tbody);
        choices.appendChild(table);
      }
    });
  console.log(`name=${name}`);
}

function setFormData(obj) {
  const formId = obj.name;
  const form = document.getElementById(formId);
  form.elements.box.value = document.getElementById('box').value;
  form.elements.quant.value = document.getElementById('quant').value;
  form.elements.quantunit.value = document.getElementById('quantunit').value;
  form.elements.labels.value = document.getElementById('labels').value;
  //console.log(form.elements);
  return true;
}

function fill_hidden() {
   for (const name of ['box', 'quant', 'quant_unit', 'labels']) {
    let e = document.getElementsByName(name);
    e[1].setAttribute("value", e[0].value);
    e[2].setAttribute("value", e[0].value);
  }
  return true;
}

function toogleCreate() {
  if (createHidden) {
    document.getElementById("create").style.display="block";
    document.getElementById("insert").style.display = "none";
    document.getElementById("exp-img").style.display = "none";
    document.getElementById("shr-img").style.display = "block";
    createHidden = false;
    }
  else {
    document.getElementById("create").style.display = "none";
    document.getElementById("insert").style.display = "block";
    document.getElementById("exp-img").style.display = "block";
    document.getElementById("shr-img").style.display = "none";
    createHidden = true;
  }
}

function copyFormOnlyData(formName) {
  const form = document.getElementById(formName);
  const compname = document.getElementById('compname').value;
  form.elements.compname.value = compname;
  form.elements.box.value = document.getElementById('box').value;
  form.elements.quant.value = document.getElementById('quant').value;
  form.elements.quantunit.value = document.getElementById('quantunit').value;
  form.elements.labels.value = document.getElementById('labels').value;
  return true;
}
