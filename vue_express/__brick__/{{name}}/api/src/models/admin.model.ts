import { Sequelize, DataTypes, Model, Optional } from 'sequelize';
import { Admin } from '@interfaces/admin.interface';
import { UserModel } from './users.model';

export type AdminCreationAttributes = Optional<Admin, 'id' | 'email'>;

export class AdminModel extends Model<Admin, AdminCreationAttributes> implements Admin {
  public id: string;
  public email: string;
  public userId: string;
  public readonly createdAt!: Date;
  public readonly updatedAt!: Date;
}

export default function (sequelize: Sequelize): typeof AdminModel {
  AdminModel.init(
    {
      id: {
        autoIncrement: false,
        type: DataTypes.UUID,
        primaryKey: true,
        defaultValue: DataTypes.UUIDV4,
      },
      email: {
        allowNull: false,
        type: DataTypes.STRING(45),
      },
    },
    {
      tableName: 'admins',
      sequelize,
    },
  );

  AdminModel.belongsTo(UserModel, { foreignKey: 'userId', as: 'roleProfile' });

  return AdminModel;
}
