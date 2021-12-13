/*
 * This file is generated by jOOQ.
 */
package com.ftpix.sss.dsl.tables;


import com.ftpix.sss.dsl.Keys;
import com.ftpix.sss.dsl.SSS;
import com.ftpix.sss.dsl.tables.records.UserRecord;

import java.util.Arrays;
import java.util.List;

import org.jooq.Field;
import org.jooq.ForeignKey;
import org.jooq.Name;
import org.jooq.Record;
import org.jooq.Row8;
import org.jooq.Schema;
import org.jooq.Table;
import org.jooq.TableField;
import org.jooq.TableOptions;
import org.jooq.UniqueKey;
import org.jooq.impl.DSL;
import org.jooq.impl.SQLDataType;
import org.jooq.impl.TableImpl;


/**
 * This class is generated by jOOQ.
 */
@SuppressWarnings({ "all", "unchecked", "rawtypes" })
public class User extends TableImpl<UserRecord> {

    private static final long serialVersionUID = 1L;

    /**
     * The reference instance of <code>sss.USER</code>
     */
    public static final User USER = new User();

    /**
     * The class holding records for this type
     */
    @Override
    public Class<UserRecord> getRecordType() {
        return UserRecord.class;
    }

    /**
     * The column <code>sss.USER.ID</code>.
     */
    public final TableField<UserRecord, String> ID = createField(DSL.name("ID"), SQLDataType.VARCHAR(48).nullable(false), this, "");

    /**
     * The column <code>sss.USER.EMAIL</code>.
     */
    public final TableField<UserRecord, String> EMAIL = createField(DSL.name("EMAIL"), SQLDataType.VARCHAR(255).nullable(false), this, "");

    /**
     * The column <code>sss.USER.FIRSTNAME</code>.
     */
    public final TableField<UserRecord, String> FIRSTNAME = createField(DSL.name("FIRSTNAME"), SQLDataType.VARCHAR(255).nullable(false), this, "");

    /**
     * The column <code>sss.USER.PASSWORD</code>.
     */
    public final TableField<UserRecord, String> PASSWORD = createField(DSL.name("PASSWORD"), SQLDataType.VARCHAR(255).nullable(false), this, "");

    /**
     * The column <code>sss.USER.LASTNAME</code>.
     */
    public final TableField<UserRecord, String> LASTNAME = createField(DSL.name("LASTNAME"), SQLDataType.VARCHAR(255).nullable(false), this, "");

    /**
     * The column <code>sss.USER.SUBSCRIPTIONEXPIRYDATE</code>.
     */
    public final TableField<UserRecord, Long> SUBSCRIPTIONEXPIRYDATE = createField(DSL.name("SUBSCRIPTIONEXPIRYDATE"), SQLDataType.BIGINT, this, "");

    /**
     * The column <code>sss.USER.SHOWANNOUNCEMENT</code>.
     */
    public final TableField<UserRecord, Byte> SHOWANNOUNCEMENT = createField(DSL.name("SHOWANNOUNCEMENT"), SQLDataType.TINYINT, this, "");

    /**
     * The column <code>sss.USER.ISADMIN</code>.
     */
    public final TableField<UserRecord, Byte> ISADMIN = createField(DSL.name("ISADMIN"), SQLDataType.TINYINT, this, "");

    private User(Name alias, Table<UserRecord> aliased) {
        this(alias, aliased, null);
    }

    private User(Name alias, Table<UserRecord> aliased, Field<?>[] parameters) {
        super(alias, null, aliased, parameters, DSL.comment(""), TableOptions.table());
    }

    /**
     * Create an aliased <code>sss.USER</code> table reference
     */
    public User(String alias) {
        this(DSL.name(alias), USER);
    }

    /**
     * Create an aliased <code>sss.USER</code> table reference
     */
    public User(Name alias) {
        this(alias, USER);
    }

    /**
     * Create a <code>sss.USER</code> table reference
     */
    public User() {
        this(DSL.name("USER"), null);
    }

    public <O extends Record> User(Table<O> child, ForeignKey<O, UserRecord> key) {
        super(child, key, USER);
    }

    @Override
    public Schema getSchema() {
        return aliased() ? null : SSS.SSS;
    }

    @Override
    public UniqueKey<UserRecord> getPrimaryKey() {
        return Keys.KEY_USER_PRIMARY;
    }

    @Override
    public List<UniqueKey<UserRecord>> getUniqueKeys() {
        return Arrays.asList(Keys.KEY_USER_EMAIL);
    }

    @Override
    public User as(String alias) {
        return new User(DSL.name(alias), this);
    }

    @Override
    public User as(Name alias) {
        return new User(alias, this);
    }

    /**
     * Rename this table
     */
    @Override
    public User rename(String name) {
        return new User(DSL.name(name), null);
    }

    /**
     * Rename this table
     */
    @Override
    public User rename(Name name) {
        return new User(name, null);
    }

    // -------------------------------------------------------------------------
    // Row8 type methods
    // -------------------------------------------------------------------------

    @Override
    public Row8<String, String, String, String, String, Long, Byte, Byte> fieldsRow() {
        return (Row8) super.fieldsRow();
    }
}
