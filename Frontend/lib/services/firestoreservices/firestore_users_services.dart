import 'package:ignite/dbrepositories/dbrepository.dart';
import 'package:ignite/factories/repositoriesfactories/firestorerepositoriesfactory.dart';

import '../../models/user.dart';
import '../users_services.dart';

class FirestoreUsersServices implements UsersServices {
  DbRepository<User> _usersController =
      FirestoreRepositoriesFactory().getUsersRepository();
  @override
  Future<User> getUserById(String id) async {
    return await _usersController.get(id);
  }

  @override
  Future<User> getUserByMail(String mail) async {
    List<User> usersList = await _usersController.getAll();
    for (User user in usersList) {
      if (user.getMail() == mail) return user;
    }
    return null;
  }

  @override
  Future<bool> isUserFiremanById(String id) async {
    List<User> users = await this._usersController.getAll();
    for (User user in users) {
      if (user.getId() == id) return user.isFireman();
    }
    return false;
  }

  @override
  Future<bool> isUserFirstAccessById(String id) async {
    List<User> users = await this._usersController.getAll();
    for (User user in users) {
      if (user.getId() == id) return user.isFirstAccess();
    }
    return false;
  }

  @override
  Future<bool> setFirstAccessToFalseById(String id) async {
    List<User> users = await this._usersController.getAll();
    for (User user in users) {
      if (user.getId() == id) {
        user.setFirstAccess(false);
        this._usersController.update(user);
        return true;
      }
    }
    return false;
  }

  @override
  Future<User> addUser(User newUser) async {
    return await _usersController.insert(newUser);
  }

  @override
  Future<User> updateUser(User updatedUser) async {
    return await _usersController.update(updatedUser);
  }

  @override
  Future<bool> userExistsByMail(String mail) async {
    User user = await this.getUserByMail(mail);
    return (user == null) ? false : true;
  }
}
