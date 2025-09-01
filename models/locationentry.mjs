import { seqlz } from "../db.mjs";
import { DataTypes } from "sequelize";

const LocationEntry = seqlz.define("location_entry", {
  id: { type: DataTypes.INTEGER, autoIncrement: true, allowNull: false, primaryKey: true, unique: true },
  labels: { type: DataTypes.TEXT, allowNull: false, defaultValue: '' },
  location_id: { type: DataTypes.INTEGER, allowNull: false, defaultValue: 0 },
  component_id: { type: DataTypes.INTEGER, allowNull: false, defaultValue: 0 },
  supcode_id: { type: DataTypes.INTEGER, allowNull: false, defaultValue: 0 },
  quant_unit: { type: DataTypes.INTEGER, allowNull: false, defaultValue: 0 },
  quant_min: { type: DataTypes.INTEGER, allowNull: false, defaultValue: 0 },
  quant: { type: DataTypes.INTEGER, allowNull: false, defaultValue: 0 },
  box: { type: DataTypes.INTEGER, allowNull: false, defaultValue: 1 },
  url: {
    type: DataTypes.VIRTUAL,
    get() {
      return '/locationentry/' + this.id;
    }
  }
},
                           {
                               timestamps: false,
                               freezeTableName: true,
                               raw: true
                           });

export default LocationEntry;
