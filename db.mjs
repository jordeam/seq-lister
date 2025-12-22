import { Sequelize } from "sequelize";
import fs from 'fs';
import jsyaml from 'js-yaml';

const yamltext = fs.readFileSync('sequelize-conf.yaml', 'utf8');
const params = jsyaml.load(yamltext, 'utf8');
export const seqlz = new Sequelize(params.dbname,
                                   params.username,
                                   params.password,
                                   {
                                     host: params.hostname,
                                     dialect: params.dialect,
                                     // logging: false,
                                   });

export const testDbConnection = async () => {
    try {
        await seqlz.authenticate();
        console.log("Connection has been established successfully.");
    } catch (error) {
        console.error("Unable to connect to the database:", error);
    }
};
