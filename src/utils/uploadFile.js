
const uploadFile = (file,path) => {
    let EDFile = file
    EDFile.mv(`../images/path/${EDFile.name}`,err => {
        if(err) {
            return ({ success: false, message: err })
        } else {
            return ({ success: true, message: 'File upload'})
        }
    });
}

module.exports = uploadFile;