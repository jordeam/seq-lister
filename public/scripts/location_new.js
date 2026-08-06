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

//
// Sent to Assembly
//

document.getElementById('sent').addEventListener('keydown', event => {
  if (event.key === 'Enter') {
    event.preventDefault(); // Prevents form submission if input is inside a <form>
    sentOk();
  }
  else if (event.key === 'Escape') {
    event.preventDefault();
    sentClose();
  }
});

function sentEdit(wdg) {
  document.getElementById('sent_dialog').style.display='block';
  const sent = document.getElementById('sent');
  const sent_form = document.getElementById('sent_form');
  sent_form.elements['le_id'].value = wdg.getAttribute('name');
  sent_form.elements['needed'].value = wdg.getAttribute('value');
  sent.value = wdg.innerHTML;
  sent.focus();
  sent.select();
}

function sentClose() {
  const diag = document.getElementById('sent_dialog');
  diag.style.display = 'none';
}

function sentOk() {
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
  const le_id = sent_form.elements['le_id'].value;
  const needed = +sent_form.elements['needed'].value;
  const req = new Request('/locationentry/'+le_id+'/sent', requestOptions);
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
      if (le_id > 0) {
        const elt = document.getElementById('sent_'+le_id);
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

//
// Stock
//
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

function stockEdit(wdg) {
  document.getElementById('stock_dialog').style.display = 'block';
  const stock = document.getElementById('stock');
  const stock_form = document.getElementById('stock_form');
  stock_form.elements['le_id'].value = wdg.getAttribute('value');
  stock.value = wdg.innerHTML;
  stock.focus();
  stock.select();
  console.log(stock_form);
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

//
// Box
//
document.getElementById('box').addEventListener('keydown', event => {
  if (event.key === 'Enter') {
    event.preventDefault(); // Prevents form submission if input is inside a <form>
    boxOk();
  }
  else if (event.key === 'Escape') {
    event.preventDefault();
    boxClose();
  }
});

function boxClose() {
  document.getElementById('box_dialog').style.display = 'none';
}

function boxEdit(wdg) {
  document.getElementById('box_dialog').style.display = 'block';
  const box = document.getElementById('box');
  const box_form = document.getElementById('box_form');
  const le_id = wdg.getAttribute('value');
  console.log(le_id);
  box_form.elements['le_id'].value = le_id;
  box.value = wdg.innerHTML;
  box.focus();
  box.select();
  // console.log(box_form);
}

function boxOk() {
  const diag = document.getElementById('box_dialog');
  const box_form = document.getElementById('box_form');
  const box = document.getElementById('box');
  // console.log(box.value);
  const val = +box.value;
  const requestOptions = {
    method: 'POST',
    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
    body: new URLSearchParams({
      box: val,
    }).toString(),
  };
  const le_id = box_form.elements['le_id'].value;
  console.log(`le_id=${le_id}`);
  const req = new Request('/locationentry/'+le_id+'/box', requestOptions);
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
      if (le_id > 0) {
        const elt = document.getElementById("box_"+le_id);
        elt.innerHTML = data.box;
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

// 2. Define the click handler function
function optcompRadioClick(event) {
  const optform = document.getElementById('optcomp_form');
  optform.elements['new_pn_id'].value = event.target.value;
}

function optcompOk() {
  const optform = document.getElementById('optcomp_form');
  const newPNId = optform.elements['new_pn_id'].value;
  const leId = optform.elements['le_id'].value;
  console.log(`le_id=${leId} to set with newPNId=${newPNId}`);
  const requestOptions = {
    method: 'POST',
    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
    body: new URLSearchParams({
      newPNId,
    }).toString(),
  };
  const req = new Request('/locationentry/' + leId + '/newPartnumber', requestOptions);
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
      if (leId > 0) {
        document.getElementById(`pn_${leId}`).innerHTML = data.partnumber.partnumber;
        document.getElementById(`oc_${leId}`).innerHTML = data.partnumber.ordercode;
      }
    })
    .catch(error => {
      console.error('Fetch operation failed:', error);
    });
  document.getElementById('optcomp_dialog').style.display = 'none';
}

function optcompEdit(wdg) {
  document.getElementById('optcomp_dialog').style.display = 'block';
  const le_id = +wdg.getAttribute('value');
  const optform = document.getElementById('optcomp_form');
  optform.elements['le_id'].value = le_id;
  const url = '/locationentry/' + le_id + '/optcomp';
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
      const title = document.getElementById('optcomp_title');
      table.replaceChildren();
      title.innerText = '';
      const tbody = document.createElement('tbody');
      const theaders = ['', 'Partnumber', 'Fabricante', 'Fornecedor', 'Código', 'Descrição', 'Localizações'];
      const tr = document.createElement('tr');
      for (const e of theaders) {
        const th = document.createElement('th');
        th.innerText = `${e}`;
        tr.appendChild(th);
      }
      tbody.appendChild(tr);
      if (data.parts.length > 0) {
        title.innerText = `${data.component.group.name} - ${data.component.name} - ${data.component.case.name}`;
      }
      console.log(`parts[0].locs[0].name=${data.parts[0].locs[0].name}`);
      for (const elt of data.parts) {
        const tr = document.createElement('tr');
        const td = document.createElement('td');
        const inp = document.createElement('input');
        inp.type = 'radio';
        inp.name = 'pn';
        inp.value = elt.id;
        inp.addEventListener('click', optcompRadioClick);
        // console.log (`elt.id=${elt.id} pn_id=${data.le.supcode_id}`);
        if (data.le.supcode_id == elt.id)
          inp.checked = true;
        td.appendChild(inp);
        tr.appendChild(td);
        for (const field of [elt.partnumber, elt.manufacturer.name, elt.supplier.name, elt.ordercode, elt.descr]) {
          const td = document.createElement('td');
          td.textContent = field;
          tr.appendChild(td);
        }
        const tdLoc = document.createElement('td');
        tdLoc.innerHTML = elt.locs.map(x => `<a href=/location/${x.id}>${x.name}</a>`).join(', &nbsp; ');
        tr.appendChild(tdLoc);
        tbody.appendChild(tr);
      }
      table.appendChild(tbody);
    })
    .catch(error => {
      console.error('Fetch operation failed:', error);
    });
}
