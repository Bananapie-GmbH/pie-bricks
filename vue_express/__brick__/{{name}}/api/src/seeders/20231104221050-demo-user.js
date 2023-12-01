'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  up: async (queryInterface, Sequelize) => {
    queryInterface.bulkDelete('users', { id: { [Sequelize.Op.eq]: 'c7e4d7c7-6f4d-4a9e-8b1c-9c3f8d5a6f7a' } }, {});
    queryInterface.bulkDelete('admins', { id: { [Sequelize.Op.eq]: 'a7e4d7c7-6f4d-4a9e-8b1c-9c3f8d5a6f7b' } }, {});

    return queryInterface
      .bulkInsert('users', [
        {
          id: 'c7e4d7c7-6f4d-4a9e-8b1c-9c3f8d5a6f7a',
          email: 'admin@admin.de',
          password: '$2b$10$2hpXzmjJXvTm9N4LZe0XNet.2Xa448PXjXZeXSlVEzkQZfQit5zr6', //admin
          role: 'admin',
        },
      ])
      .then(() => {
        return queryInterface.bulkInsert('admins', [
          {
            id: 'a7e4d7c7-6f4d-4a9e-8b1c-9c3f8d5a6f7b',
            email: 'admin@admin.de',
            userId: 'c7e4d7c7-6f4d-4a9e-8b1c-9c3f8d5a6f7a',
          },
        ]);
      })
      .catch(err => {
        console.log(err);
        return Promise.reject(err);
      });
  },
  down: (queryInterface, Sequelize) => {
    return queryInterface.bulkDelete('users', null, {});
  },
};
