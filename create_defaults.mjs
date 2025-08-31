import Suppliercode from "./models/suppliercode.mjs";

export async function create_defaults() {
  if (!await Suppliercode.findOne({where: {id: 0}})) {
    await Suppliercode.create({id: 0, partnumber: 'DEFAULT', ordercode: 'DEFAULT'});
  }
}
