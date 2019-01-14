@IsTest
public with sharing class XC_ComparatorTest {

    @IsTest
    static void testIsDiff() {
        Account one = new Account(Name = 'One');
        Account two = new Account(Name = 'Two');

        Boolean isDiff = XC_Comparator.isDiff(one, two, new List<String>{'Name'});

        System.assert(isDiff);

        isDiff = XC_Comparator.isDiff(one, two, 'Name');

        System.assert(isDiff);
    }

    @IsTest
    static void testGetDiff() {
        Account one = new Account(Name = 'One');
        Account two = new Account(Name = 'Two');

        Set<String> diffSet = XC_Comparator.getDiff(one, two, new List<String>{'Name'});

        System.assertEquals(1, diffSet.size());
        System.assert(diffSet.contains('Name'));
    }

    @IsTest
    static void testGetChanged() {
        List<Account> newList = new List<Account>();
        newList.add(new Account(Name = 'One'));
        newList.add(new Account(Name = 'Three'));
        insert newList;

        Map<Id, Account> oldMap = new Map<Id, Account>(newList);
        Account account = oldMap.get(newList[1].Id);
        account.Name = 'Two';
        oldMap.put(account.Id, account);

        List<Account> diffSet = XC_Comparator.getChanged(newList, oldMap, new List<String>{'Name'});

        System.assertEquals(1, diffSet.size());
        System.assertEquals(account.Id, diffSet[0].Id);
    }
}