@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Grocery Header Consumption View 110'
@Search.searchable: true
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true

define root view entity ZC_GROCERY_HDR_110
  provider contract transactional_query
  as projection on ZI_GROCERY_HDR_110
{
    key OrderUuid,

    @Search.defaultSearchElement: true
    OrderId,

    @Search.defaultSearchElement: true
    CustomerName,

    @Semantics.amount.currencyCode: 'CurrencyCode'
    TotalPrice,
    
    CurrencyCode,
    
    OverallStatus,

    /* Administrative fields */
    LocalCreatedBy,
    LocalCreatedAt,
    LocalLastChangedBy,
    LocalLastChangedAt,
    LastChangedAt,

    /* Association - Redirected to Grocery Item Consumption */
    _Items : redirected to composition child ZC_GROCERY_ITM_110
}
