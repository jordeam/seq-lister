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
  const req = new Request('/search/comp?expr=' + encodeURIComponent(name));
  fetch(req)
    .then(res => res.json())
    .then(data => {
      // console.log(data);
      choices.innerHTML = '';
      let table, tbody;
      if (data.length > 0) {
        // has some data
        const locid = +document.getElementById("locid").getAttribute('value');
        const utable = document.getElementById("utable").getAttribute('value');
        console.log(`locid = ${locid} table=${utable}`);
        const choices = document.getElementById("choices");
        table = document.createElement('table');
        tbody = document.createElement('tbody');
        for (let elt of data) {
          const tr = document.createElement('tr');
          const td1 = document.createElement('td');
          td1.textContent = elt.gname;
          tr.appendChild(td1);
          const td2 = document.createElement('td');
          td2.textContent = elt.name;
          tr.appendChild(td2);
          const td3 = document.createElement('td');
          td3.textContent = elt.case;
          tr.appendChild(td3);
          const td4 = document.createElement('td');
          td4.innerHTML = '<a class="btn btn-primary" href="/component/' + elt.id +'"><img src="/image/edit-icon.svg" alt="Editar" width="20pt" height="24pt"></a>';
          tr.appendChild(td4);
          const td5 = document.createElement('td');
          const form = document.createElement('form');
          form.setAttribute('method', 'POST');
          form.setAttribute('action', '/locationentry/insert/'+locid+utable);
          form.innerHTML = '<input type="hidden" name="component_id" value='+elt.id+'> <button class="btn btn-primary" type="submit">Inserir</button>';

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

function fill_hidden() {
   for (const name of ['box', 'quant', 'quant_unit', 'labels']) {
    let e = document.getElementsByName(name);
    e[1].setAttribute("value", e[0].value);
    e[2].setAttribute("value", e[0].value);
  }
  return true;
}
