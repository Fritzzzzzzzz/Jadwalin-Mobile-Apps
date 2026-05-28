const express =
    require("express");

const {

    body,

} = require(
    "express-validator"
);

const router =
    express.Router();

const authController =
    require(
        "../controllers/auth.controller"
    );

const validate =
    require(
        "../middleware/validation.middleware"
    );

router.post(

    "/register",

    [

        body("nama")
        .notEmpty()
        .withMessage(
            "Nama wajib diisi"
        ),

        body("email")
        .isEmail()
        .withMessage(
            "Email tidak valid"
        ),

        body("password")
        .isLength({

            min: 6,

        })

        .withMessage(

            "Password minimal 6 karakter"

        ),

    ],

    validate,

    (req, res) =>

    authController.register(

        req,
        res,

    ),

);

router.post(

    "/login",

    [

        body("email")
        .isEmail()
        .withMessage(

            "Email tidak valid"

        ),

        body("password")
        .notEmpty()
        .withMessage(

            "Password wajib diisi"

        ),

    ],

    validate,

    (req, res) =>

    authController.login(

        req,
        res,

    ),

);

module.exports =
    router;