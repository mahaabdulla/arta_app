class Permissions {
  String? createCategorie;
  String? destroyCategorie;
  String? viewCategorie;
  String? updateCategorie;
  String? createRegion;
  String? destroyRegion;
  String? viewRegion;
  String? updateRegion;
  String? createComment;
  String? destroyComment;
  String? viewComment;
  String? updateComment;
  String? createPermission;
  String? destroyPermission;
  String? viewPermission;
  String? updatePermission;
  String? createRole;
  String? destroyRole;
  String? viewRole;
  String? updateRole;
  String? createComplaint;
  String? destroyComplaint;
  String? viewComplaint;
  String? updateComplaint;
  String? destroyUser;
  String? viewUsers;
  String? viewUser;
  String? createListing;
  String? destroyListing;
  String? updateListing;
  String? assignRole;
  String? revokeRole;

  Permissions(
      {this.createCategorie,
      this.destroyCategorie,
      this.viewCategorie,
      this.updateCategorie,
      this.createRegion,
      this.destroyRegion,
      this.viewRegion,
      this.updateRegion,
      this.createComment,
      this.destroyComment,
      this.viewComment,
      this.updateComment,
      this.createPermission,
      this.destroyPermission,
      this.viewPermission,
      this.updatePermission,
      this.createRole,
      this.destroyRole,
      this.viewRole,
      this.updateRole,
      this.createComplaint,
      this.destroyComplaint,
      this.viewComplaint,
      this.updateComplaint,
      this.destroyUser,
      this.viewUsers,
      this.viewUser,
      this.createListing,
      this.destroyListing,
      this.updateListing,
      this.assignRole,
      this.revokeRole});

  Permissions.fromJson(Map<String, dynamic> json) {
    createCategorie = json['create-categorie'];
    destroyCategorie = json['destroy-categorie'];
    viewCategorie = json['view-categorie'];
    updateCategorie = json['update-categorie'];
    createRegion = json['create-region'];
    destroyRegion = json['destroy-region'];
    viewRegion = json['view-region'];
    updateRegion = json['update-region'];
    createComment = json['create-comment'];
    destroyComment = json['destroy-comment'];
    viewComment = json['view-comment'];
    updateComment = json['update-comment'];
    createPermission = json['create-permission'];
    destroyPermission = json['destroy-permission'];
    viewPermission = json['view-permission'];
    updatePermission = json['update-permission'];
    createRole = json['create-role'];
    destroyRole = json['destroy-role'];
    viewRole = json['view-role'];
    updateRole = json['update-role'];
    createComplaint = json['create-complaint'];
    destroyComplaint = json['destroy-complaint'];
    viewComplaint = json['view-complaint'];
    updateComplaint = json['update-complaint'];
    destroyUser = json['destroy-user'];
    viewUsers = json['view-users'];
    viewUser = json['view-user'];
    createListing = json['create-listing'];
    destroyListing = json['destroy-listing'];
    updateListing = json['update-listing'];
    assignRole = json['assignRole'];
    revokeRole = json['revokeRole'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['create-categorie'] = this.createCategorie;
    data['destroy-categorie'] = this.destroyCategorie;
    data['view-categorie'] = this.viewCategorie;
    data['update-categorie'] = this.updateCategorie;
    data['create-region'] = this.createRegion;
    data['destroy-region'] = this.destroyRegion;
    data['view-region'] = this.viewRegion;
    data['update-region'] = this.updateRegion;
    data['create-comment'] = this.createComment;
    data['destroy-comment'] = this.destroyComment;
    data['view-comment'] = this.viewComment;
    data['update-comment'] = this.updateComment;
    data['create-permission'] = this.createPermission;
    data['destroy-permission'] = this.destroyPermission;
    data['view-permission'] = this.viewPermission;
    data['update-permission'] = this.updatePermission;
    data['create-role'] = this.createRole;
    data['destroy-role'] = this.destroyRole;
    data['view-role'] = this.viewRole;
    data['update-role'] = this.updateRole;
    data['create-complaint'] = this.createComplaint;
    data['destroy-complaint'] = this.destroyComplaint;
    data['view-complaint'] = this.viewComplaint;
    data['update-complaint'] = this.updateComplaint;
    data['destroy-user'] = this.destroyUser;
    data['view-users'] = this.viewUsers;
    data['view-user'] = this.viewUser;
    data['create-listing'] = this.createListing;
    data['destroy-listing'] = this.destroyListing;
    data['update-listing'] = this.updateListing;
    data['assignRole'] = this.assignRole;
    data['revokeRole'] = this.revokeRole;
    return data;
  }
}