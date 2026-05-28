const authService =
    require("../services/auth.service");

class AuthController {

    async register(
        req,
        res,
    ) {

        try {

            const user =
                await authService.register(
                    req.body
                );

            res.status(201).json({

                success: true,

                message: "Register berhasil",

                data: user,

            });

        } catch (error) {

            res.status(400).json({

                success: false,

                message: error.message,

            });

        }

    }

    async login(
        req,
        res,
    ) {

        try {

            const {

                email,
                password,

            } = req.body;

            const result =
                await authService.login(

                    email,
                    password,

                );

            res.status(200).json({

                success: true,

                message: "Login berhasil",

                data: result,

            });

        } catch (error) {

            res.status(400).json({

                success: false,

                message: error.message,

            });

        }

    }

}

module.exports =
    new AuthController();