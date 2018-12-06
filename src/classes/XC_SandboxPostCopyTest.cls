@IsTest
public class XC_SandboxPostCopyTest {

    @TestSetup
    static void setup() {
        List<User> sysAdminList = [
                SELECT Id, Email
                FROM User
                WHERE Profile.Name = 'System Administrator' AND IsActive = true
        ];

        for(User sysAdmin : sysAdminList) {
            String email = sysAdmin.Email;
            email = email.replace('@', '=');
            email += '@example.com';
            sysAdmin.Email = email;
        }

        update sysAdminList;
    }

    @IsTest
    static void testRunApexClass() {
        Test.startTest();

        Account org = new Account(Name = 'XC_SandboxPostCopyTest_Org');
        Account sand = new Account(Name = 'XC_SandboxPostCopyTest_Sand');
        List<Account> accountList = new List<Account>{
                org, sand
        };
        insert accountList;

        SandboxContext sc;

        XC_SandboxPostCopy spc = new XC_SandboxPostCopy();
        spc.runApexClass(sc);

        Test.stopTest();

        List<User> sysAdminList = [
                SELECT Id, Email
                FROM User
                WHERE Profile.Name = 'System Administrator' AND IsActive = true
        ];

        for(User sysAdmin : sysAdminList) {
            System.assert(!sysAdmin.Email.endsWith('@example.com'));
        }
    }

}