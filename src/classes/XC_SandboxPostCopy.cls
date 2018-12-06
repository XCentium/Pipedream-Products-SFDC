global with sharing class XC_SandboxPostCopy implements SandboxPostCopy {

    global void runApexClass(SandboxContext context) {
        List<User> sysAdminList = [
                SELECT Id, Email
                FROM User
                WHERE Profile.Name = 'System Administrator'
                AND IsActive = true
        ];

        for (User u : sysAdminList) {
            String email = u.Email;
            email = email.replace('@example.com', '');
            email = email.replace('=', '@');
            u.Email = email;
        }

        update sysAdminList;
    }
}