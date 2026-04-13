@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Grocery Item Consumption View 110'
@Search.searchable: true
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true

define view entity ZC_GROCERY_ITM_110
  as projection on ZI_GROCERY_ITM_110
{
  key ItemUuid,
  
  OrderUuid,

  @Search.defaultSearchElement: true
  ItemId,

  @Search.defaultSearchElement: true
  Product,
  
  @Semantics.quantity.unitOfMeasure: 'Unit'
  Quantity,
  Unit,

  @Semantics.amount.currencyCode: 'CurrencyCode'
  Price,
  CurrencyCode,

  LocalCreatedBy,
  LocalCreatedAt,
  LocalLastChangedBy,
  LocalLastChangedAt,
  LastChangedAt,

  /* Association - Redirected to Header Consumption */
  _Header : redirected to parent ZC_GROCERY_HDR_110
}
