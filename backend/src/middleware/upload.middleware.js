const multer =
    require("multer");

const path =
    require("path");

const storage =
    multer.diskStorage({

        destination: function(

            req,
            file,
            cb,

        ) {

            cb(
                null,
                "uploads/",
            );

        },

        filename: function(

            req,
            file,
            cb,

        ) {

            const uniqueName =

                Date.now() +

                path.extname(
                    file.originalname,
                );

            cb(

                null,

                uniqueName,

            );

        },

    });

const fileFilter =

    (

        req,
        file,
        cb,

    ) => {

        const allowed =

            /jpg|jpeg|png/;

        const valid =

            allowed.test(

                path.extname(

                    file.originalname,

                ).toLowerCase()

            );

        if (valid) {

            cb(
                null,
                true,
            );

        } else {

            cb(

                new Error(
                    "Format harus jpg/jpeg/png",
                ),

                false,

            );

        }

    };

module.exports =

    multer({

        storage,

        fileFilter,

        limits: {

            fileSize: 5 * 1024 * 1024,

        },

    });
