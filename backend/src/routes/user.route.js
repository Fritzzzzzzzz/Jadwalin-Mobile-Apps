const express =
    require("express");

const router =
    express.Router();

const userController =
    require(
        "../controllers/user.controller"
    );

const authMiddleware =
    require(
        "../middleware/auth.middleware"
    );

const upload =
    require(
        "../middleware/upload.middleware"
    );

router.get(

    "/profile",

    authMiddleware,

    userController.profile,

);

router.get(

    "/all",

    authMiddleware,

    userController.getAllUser,

);

router.patch(

    "/change-password",

    authMiddleware,

    userController
    .changePassword,

);

router.put(

    "/profile",

    authMiddleware,

    userController.updateProfile

);

router.put(

    "/foto-profil",

    authMiddleware,

    upload.single(
        "fotoProfil"
    ),

    userController
    .uploadFotoProfil,

);


module.exports =
    router;
