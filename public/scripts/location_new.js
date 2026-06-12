function location_create(obj) {
    var str = prompt("Nome da localização:", "");
    if (str != null) {
        str = str.trim();
        if (str.length > 0) {
            obj.locname.value = str;
            return true;
        }
        else
	    return false;
    }
    else
        return false;
}

document.getElementById('sent').addEventListener('keydown', event => {
  if (event.key === 'Enter') {
    event.preventDefault(); // Prevents form submission if input is inside a <form>
    okSent();
  }
  else if (event.key === 'Escape') {
    event.preventDefault();
    closeSent();
  }
});

function editSent(wdg, needed) {
  document.getElementById('sent_dialog').style.display='block';
  const n = wdg.getAttribute('value');
  const sent = document.getElementById('sent');
  const sent_form = document.getElementById('sent_form');
  sent_form.elements['le_id'].value = wdg.getAttribute('name');
  sent_form.elements['needed'].value = needed;
  sent.value = n;
  sent.focus();
  sent.select();
  // console.log(sent_form);
}

function closeSent() {
  const diag = document.getElementById('sent_dialog');
  diag.style.display = 'none';
}

function okSent() {
  const diag = document.getElementById('sent_dialog');
  const sent_form = document.getElementById('sent_form');
  const sent = document.getElementById('sent');
  // console.log(sent.value);
  const val = +sent.value;
  const requestOptions = {
    method: 'POST',
    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
    body: new URLSearchParams({
      sent: val,
    }).toString(),
  };
  const current_id = sent_form.elements['le_id'].value;
  const needed = +sent_form.elements['needed'].value;
  const req = new Request('/locationentry/'+current_id+'/sent', requestOptions);
  fetch(req)
    .then(res => {
      if (!res.ok) {
        throw new Error(`HTTP error! Status: ${response.status}`);
      }
      // console.log(res);
      return res.json(); // Returns a promise with the parsed JSON
    })
    .then(data => {
      // console.log(data); // Use your JSON data here
      if (current_id > 0) {
        const elt = document.getElementById(current_id);
        elt.innerHTML = data.sent;
        if (needed > +data.sent)
          elt.style.background = "#f55";
        else
          elt.style.background = '#5df';
      }
    })
    .catch(error => {
      console.error('Fetch operation failed:', error);
    });
  diag.style.display = 'none';
}

document.getElementById('stock').addEventListener('keydown', event => {
  if (event.key === 'Enter') {
    event.preventDefault(); // Prevents form submission if input is inside a <form>
    stockOk();
  }
  else if (event.key === 'Escape') {
    event.preventDefault();
    stockClose();
  }
});

function stockClose() {
  document.getElementById('stock_dialog').style.display = 'none';
}

function stockEdit(wdg, le_id) {
  document.getElementById('stock_dialog').style.display = 'block';
  const n = wdg.getAttribute('value');
  const stock = document.getElementById('stock');
  const stock_form = document.getElementById('stock_form');
  stock_form.elements['le_id'].value = le_id;
  stock.value = n;
  stock.focus();
  stock.select();
  // console.log(stock_form);
}

function stockOk() {
  const diag = document.getElementById('stock_dialog');
  const stock_form = document.getElementById('stock_form');
  const stock = document.getElementById('stock');
  // console.log(stock.value);
  const val = +stock.value;
  const requestOptions = {
    method: 'POST',
    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
    body: new URLSearchParams({
      stock: val,
    }).toString(),
  };
  const current_id = stock_form.elements['le_id'].value;
  const req = new Request('/locationentry/'+current_id+'/stock', requestOptions);
  fetch(req)
    .then(res => {
      if (!res.ok) {
        throw new Error(`HTTP error! Status: ${res.status}`);
      }
      // console.log(res);
      return res.json(); // Returns a promise with the parsed JSON
    })
    .then(data => {
      // console.log(data); // Use your JSON data here
      if (current_id > 0) {
        const elt = document.getElementById("stock_"+current_id);
        elt.innerHTML = data.stock;
      }
    })
    .catch(error => {
      console.error('Fetch operation failed:', error);
    });
  diag.style.display = 'none';
}

function optcompClose() {
  document.getElementById('optcomp_dialog').style.display = 'none';
}

function optcompEdit(wdg, comp_id) {
  document.getElementById('optcomp_dialog').style.display = 'block';
  const le_id = +wdg.getAttribute('value');
  const optcomp_form = document.getElementById('optcomp_form');
  optcomp_form.elements['le_id'].value = le_id;
  optcomp_form.elements['comp_id'].value = comp_id;
  const url = '/component/' + comp_id + '/optcomp';
  // const requestOptions = {
  //   method: 'POST',
  //   headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
  //   body: new URLSearchParams({
  //     supcode_id,
  //   }).toString(),
  // };
  fetch(url)
    .then(res => {
      if (!res.ok) {
        throw new Error(`HTTP error! Status: ${res.status}`);
      }
      // console.log(res);
      return res.json(); // Returns a promise with the parsed JSON
    })
    .then(data => {
      console.log(data); // Use your JSON data here
      const table = document.getElementById('optcomp_table');
      const tbody = document.createElement('tbody');
      const theaders = ['Partnumber', 'Fabricante', 'Fornecedor', 'Código', 'Descrição'];
      const tr = document.createElement('tr');
      for (const e of theaders) {
        const th = document.createElement('th');
        th.innerHTML = `${e}`;
        tr.appendChild(th);
      }
      tbody.appendChild(tr);

      for (const elt of data.partnumbers) {
        const tr = document.createElement('tr');
        const td1 = document.createElement('td');
        td1.textContent = elt.partnumber+'';
        tr.appendChild(td1);
        const td2 = document.createElement('td');
        td2.textContent = elt.manufact_id;
        tr.appendChild(td2);
        console.log(elt);
        tbody.appendChild(tr);
      }
      table.appendChild(tbody);
    })
    .catch(error => {
      console.error('Fetch operation failed:', error);
    });
}
