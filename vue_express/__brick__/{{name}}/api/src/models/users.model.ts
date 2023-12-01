import { Sequelize, DataTypes, Model, Optional } from 'sequelize';
import { User } from '@interfaces/users.interface';
import { Role } from '@/enums/role.enum';
import adminModel from './admin.model';

export type UserCreationAttributes = Optional<User, 'id' | 'email' | 'password'>;

export class UserModel extends Model<User, UserCreationAttributes> implements User {
  public id: string;
  public email: string;
  public password: string;
  public role: Role;
  public readonly createdAt!: Date;
  public readonly updatedAt!: Date;
}

export default function (sequelize: Sequelize): typeof UserModel {
  UserModel.init(
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
      password: {
        allowNull: false,
        type: DataTypes.STRING(255),
      },
      role: {
        allowNull: false,
        defaultValue: Role.USER,
        type: DataTypes.ENUM(...Object.values(Role)),
      },
    },
    {
      tableName: 'users',
      sequelize,
    },
  );

  UserModel.hasOne(adminModel(sequelize), { foreignKey: 'userId', as: 'roleProfile' });

  return UserModel;
}
