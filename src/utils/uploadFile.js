
const uploadFile = (file,path) => {
    let archivo = file
    archivo.mv(`../images/path/${archivo.name}`,err => {
        if(err) {
            return ({ success: false, message: err })
        } else {
            return ({ success: true, message: 'File upload'})
        }
    });
}

module.exports = uploadFile;