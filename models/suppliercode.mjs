import { seqlz } from "../db.mjs";
import { DataTypes } from "sequelize";
import Component from "./component.mjs";
import Suppliers from "./supplier.mjs";

const Suppliercode = seqlz.define("suppliercode", {
  id: {type: DataTypes.INTEGER, autoIncrement: true, allowNull: false, primaryKey: true, unique: true},
  supplier_id: {type: DataTypes.INTEGER, defaultValue: 1},
  component_id: {type: DataTypes.INTEGER, defaultValue: 0},
  manufact_id: {type: DataTypes.INTEGER, defaultValue: 0},
  partnumber: { type: DataTypes.TEXT, defaultValue: ''},
  code: { type: DataTypes.TEXT, defaultValue: ''},
  rounding: { type: DataTypes.INTEGER, defaultValue: 1},
  active: { type: DataTypes.BOOLEAN, defaultValue: false},
  price: { type: DataTypes.DOUBLE, defaultValue: 0.0},
  tax: { type: DataTypes.DOUBLE, defaultValue: 0.0},
  url: {
    type: DataTypes.VIRTUAL,
    get() {
      return '/suppliercode/' + this.id;
    }
  }
},
                       {
                         timestamps: false,
                         raw: true
                       });

Suppliercode.belongsTo(Component, {foreignKey: "component_id", allowNull: true});
Suppliercode.belongsTo(Suppliers, {foreignKey: "supplier_id", allowNull: true});

export default Suppliercode;
