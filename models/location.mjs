import { seqlz } from "../db.mjs";
import { DataTypes } from "sequelize";

const Location = seqlz.define("location", {
  id: { type: DataTypes.INTEGER, autoIncrement: true, allowNull: false, primaryKey: true, unique: true },
  name: { type: DataTypes.TEXT, allowNull: false, defaultValue: ''},
  note: { type: DataTypes.TEXT, allowNull: false, defaultValue: ''},
  nbox: { type: DataTypes.INTEGER, allowNull: false, defaultValue: 1 },
  quant: { type: DataTypes.INTEGER, allowNull: false, defaultValue: 0 },
  bom: { type: DataTypes.TEXT, allowNull: false, defaultValue: '' },
  active: {type: DataTypes.BOOLEAN, allowNull: false, defaultValue: true},
  n_columns: {type: DataTypes.INTEGER, allowNull: false, defaultValue: 5},
  n_rows: {type: DataTypes.INTEGER, allowNull: false, defaultValue: 12},
  page_width: {type: DataTypes.REAL, allowNull: false, defaultValue: 210},
  page_height: {type: DataTypes.REAL, allowNull: false, defaultValue: 298},
  top_margin: {type: DataTypes.REAL, allowNull: false, defaultValue: 2},
  bottom_margin: {type: DataTypes.REAL, allowNull: false, defaultValue: 2},
  left_margin: {type: DataTypes.REAL, allowNull: false, defaultValue: 2},
  right_margin: {type: DataTypes.REAL, allowNull: false, defaultValue: 2},
  horiz_spacing: {type: DataTypes.REAL, allowNull: false, defaultValue: 2},
  url: {
    type: DataTypes.VIRTUAL,
    get() {
      return '/location/'+this.id;
    }
  }
},
                           {
                               timestamps: false,
                               raw: true
                           });

export default Location;
