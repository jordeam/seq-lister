import { seqlz } from "../db.mjs";
import { DataTypes } from "sequelize";

const Manufacturer = seqlz.define("manufacturers", {
  id: {type: DataTypes.INTEGER, autoIncrement: true, allowNull: false, primaryKey: true, unique: true},
  name: {type: DataTypes.TEXT, defaultValue: '', allowNull: false},
  descr: { type: DataTypes.TEXT, defaultValue: ''},
  web: { type: DataTypes.TEXT, defaultValue: ''},
  url: {
    type: DataTypes.VIRTUAL,
    get() {
      return '/manufacturer/'+this.id;
    }
  }
},
                                {
                                  timestamps: false,
                                  raw: true
                                });

export default Manufacturer;
