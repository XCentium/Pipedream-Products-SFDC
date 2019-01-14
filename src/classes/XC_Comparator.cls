public with sharing class XC_Comparator {

    public static Set<String> getDiff(SObject one, SObject two, List<String> fieldList) {
        Set<String> diffSet = new Set<String>();

        for(String field : fieldList) {
            if(one.get(field) != two.get(field)) {
                diffSet.add(field);
            }
        }

        return diffSet;
    }

    public static Boolean isDiff(SObject one, SObject two, String field) {
        return XC_Comparator.isDiff(one, two, new List<String>{field});
    }

    public static Boolean isDiff(SObject one, SObject two, List<String> fieldList) {
        Boolean isDiff = false;

        for(String field : fieldList) {
            if(one.get(field) != two.get(field)) {
                isDiff = true;
                break;
            }
        }

        return isDiff;
    }

    public static Set<Id> getChangedIds(List<SObject> newList, Map<Id, SObject> oldMap, String field) {
        Map<Id, SObject> m = new Map<Id, SObject>(getChanged(newList, oldMap, new List<String>{field}));
        return m.keySet();
    }

    public static List<SObject> getChanged(List<SObject> newList, Map<Id, SObject> oldMap, String field) {
        return getChanged(newList, oldMap, new List<String>{field});
    }

    public static List<SObject> getChanged(List<SObject> newList, Map<Id, SObject> oldMap, List<String> fieldList) {
        List<SObject> changedList = new List<SObject>();
        for(SObject newSo: newList) {
            SObject oldSo = oldMap.get(newSo.Id);
            if(XC_Comparator.isDiff(newSo, oldSo, fieldList)) {
                changedList.add(newSo);
            }
        }

        return changedList;
    }
}