import Component from "../models/component.mjs";
import Suppliercode from "../models/suppliercode.mjs";

async function create_partnumbers() {
  const comps = await Component.findAll();
  for(const comp of comps) {
    const sc = await Suppliercode.findOne({where: {component_id: comp.id}});
    if (sc) {
      console.log(`found     id:${comp.id} name:${comp.name} PN:${sc.partnumber} OC:${sc.ordercode}`);
    }
    else {
      console.log(`NOT FOUND id:${comp.id} name:${comp.name}`);
      const sc1 = await Suppliercode.create({partnumber: comp.name, component_id: comp.id, descr: 'DEFAULT'});
    }
  }
}

create_partnumbers();
