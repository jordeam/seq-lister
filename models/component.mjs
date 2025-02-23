import { seqlz } from "../db.mjs";
import { DataTypes } from "sequelize";
import Case from "./case.mjs";
import Group from "./group.mjs";

const Component = seqlz.define("component", {
  id: { type: DataTypes.INTEGER, autoIncrement: true, allowNull: false, primaryKey: true, unique: true },
  name: { type: DataTypes.TEXT, allowNull: false },
  group_id: { type: DataTypes.INTEGER, defaultValue: 0 },
  case_id: { type: DataTypes.INTEGER, defaultValue: 0 },
  url: {
    type: DataTypes.VIRTUAL,
    get() {
      return '/component/' + this.id;
    }
  },
},
  {
    timestamps: false,
    raw: true
  });

Component.belongsTo(Case, {foreignKey: "case_id", allowNull: true});
Component.belongsTo(Group, {foreignKey: "group_id", allowNull: true});

export default Component;
